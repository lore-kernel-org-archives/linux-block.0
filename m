Return-Path: <SRS0=s1xr=SI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72B0C10F06
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 14:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FA52146F
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 14:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDFOrw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Apr 2019 10:47:52 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45568 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfDFOrv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Apr 2019 10:47:51 -0400
Received: by mail-ot1-f68.google.com with SMTP id e5so8209778otk.12
        for <linux-block@vger.kernel.org>; Sat, 06 Apr 2019 07:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ueKNUTOg8ZdJQ0QeNHfqfIGN/iKPzypbmEqr7aBV6Ms=;
        b=ia1p6+Bv/f9GnJA5sa7ZINBSICSuPfilpueKHEKQdhyHS3BOCdrPA99Esme3lPMHgc
         O4q2JNwLEc7ySuVUHdLoHAkWurH48ui2KjL22+oZebc3xDWl/2EHyYKkW4bTaqnmSB9C
         cWtcLKcTh7AOxZ4WYi0V1o5NECWNXm9Crm5nr7lhBHXI3ptqABXGpeOAil9zzZbmj8/2
         mF1NY1bA3UowUenrGR6kFWr3ZzhQVTRi+smIYwXkuXwUbPTmeae2IGlGSvEN/w8bsm4B
         FyLPci4jIWYcmU2aEOAHyEEK1/IMLLNMGUHW3m7B3tdWiOqXIPCy67yg2iiPP/PrsQ81
         MGqg==
X-Gm-Message-State: APjAAAXIJekhoKmMdk6lOTb8Kc6QHUzbZN1LbCMjTdgXoI2alXSrYFyF
        hfbODOtPN8AVx0qTVsn0gPPvM7/x3n6aOHHns86RTA==
X-Google-Smtp-Source: APXvYqzrlDH9HWdp13lnGorPJYlzzleN455m7ogEg+Zi67gVcVFb0v3nQH7c0mcwDP+YyOLgtuRQJNvOSMlxClR3tZs=
X-Received: by 2002:a9d:d63:: with SMTP id 90mr12141547oti.333.1554562071109;
 Sat, 06 Apr 2019 07:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190405214245.19834-1-jpittman@redhat.com> <f737dfe8-9e7f-4cb2-1f15-82daa62c479c@kernel.dk>
In-Reply-To: <f737dfe8-9e7f-4cb2-1f15-82daa62c479c@kernel.dk>
From:   John Pittman <jpittman@redhat.com>
Date:   Sat, 6 Apr 2019 10:47:40 -0400
Message-ID: <CA+RJvhxyp2n=p2gfbkv1qHstshCBq1rO2i0quxV4HPjNsqCFpg@mail.gmail.com>
Subject: Re: [PATCH] null_blk: prevent crash from bad home_node value
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <minlei@redhat.com>,
        Yi Zhang <yizhan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens, I got some unexpected results with this patch this morning.
When loading null_blk with no arguments, I got the invalid home_node
value error message.  I did some debug and found that the values
seemed fine:

+       pr_err("g_home_node is %d", g_home_node);
+       pr_err("nr_online_nodes is %d", nr_online_nodes);
+       pr_err("NUMA_NO_NODE is %d", NUMA_NO_NODE);
+
+       if (g_home_node >= nr_online_nodes) {
+               pr_err("null_blk: invalid home_node value\n");
+               g_home_node = NUMA_NO_NODE;
+       }
+
        if (g_queue_mode == NULL_Q_RQ) {
                pr_err("null_blk: legacy IO path no longer available\n");
                return -EINVAL;

[root@localhost linux]# modprobe null_blk
[  296.336473] g_home_node is -1
[  296.336474] nr_online_nodes is 1
[  296.336514] NUMA_NO_NODE is -1
[  296.336558] null_blk: invalid home_node value
[  296.338825] null: module loaded

[root@localhost linux]# numactl --hardware
available: 1 nodes (0)
node 0 cpus: 0 1 2 3
node 0 size: 828 MB
node 0 free: 451 MB
node distances:
node   0
  0:  10

Fortunately, and also unexpectedly to me, I was able to fix the issue
just by casting nr_online_nodes as an int.

+       if (g_home_node >= (int)nr_online_nodes) {
+               pr_err("null_blk: invalid home_node value\n");
+               g_home_node = NUMA_NO_NODE;
+       }
+

Would you like me to send in a v2 for this?
Thanks.

On Fri, Apr 5, 2019 at 6:22 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 4/5/19 3:42 PM, John Pittman wrote:
> > At module load, if the selected home_node value is greater than
> > the available numa nodes, the system will crash in
> > __alloc_pages_nodemask() due to a bad paging request.  Prevent this
> > user error crash by detecting the bad value, logging an error, and
> > setting g_home_node back to the default of NUMA_NO_NODE.
>
> Applied, thanks.
>
> --
> Jens Axboe
>
