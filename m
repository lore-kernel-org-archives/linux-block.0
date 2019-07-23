Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEA6C7618F
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 02:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8C32238B
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 02:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbfGWCTl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 22:19:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730479AbfGWCTk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 22:19:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9BFB13083047;
        Tue, 23 Jul 2019 02:19:40 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE32B5C225;
        Tue, 23 Jul 2019 02:19:34 +0000 (UTC)
Date:   Tue, 23 Jul 2019 10:19:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     davidc502 <davidc502@tds.net>
Cc:     linux-block@vger.kernel.org, ilnux-nvme@lists.infradead.org
Subject: Re: fstrim error - AORUS NVMe Gen4 SSD
Message-ID: <20190723021928.GF30776@ming.t460p>
References: <fb510e33-5c81-6d62-fcde-a2989b3a1a8f@tds.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb510e33-5c81-6d62-fcde-a2989b3a1a8f@tds.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 23 Jul 2019 02:19:40 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Sat, Jul 20, 2019 at 09:41:24PM -0500, davidc502 wrote:
>  Hello,
> 
>  I've assembled a X570 board with a 1TB AORUS NVMe Gen4 SSD.
> 
>  When attempting to fstrim the NVMe, I receive the following error.
>  davidc502@Ryzen-3900x:~$ sudo fstrim -a -v
>  fstrim: /boot/efi: FITRIM ioctl failed: Input/output error
>  fstrim: /: FITRIM ioctl failed: Input/output error
> 
>  Anyhow, I have put some details below which might be helpful. Note that
> this NVMe is supposed to be TRIM and SMART compliant. The SMART outputs are
> available using the utility “nvme-cli”.
>  I am willing to provide whatever command outputs that are needed to help
> solve this issue.
> 
>  OS= Ubuntu 18.4.2 LTS
>  Different Kernels I’ve tried = 5.1.16, 5.2 rc7, and 4.18
>  fstrim version =  fstrim from util-linux 2.31.1
>  Firmware version for Aorus NVMe = EGFM11.0
>

I saw discard timeout on HGST 1.6TB NVMe, not sure if yours is same with
that one.

Could you collect logs via the following steps?

Suppose your nvme disk name is /dev/nvme0n1:

1) queue limits log:

	#(cd /sys/block/nvme0n1/queue && find . -type f -exec grep -aH . {} \;)


2) NVMe IO trace

- enable nvme IO trace before running fstrim: 

	#echo 1  > /sys/kernel/debug/tracing/events/nvme_setup_cmd/enable
	#echo 1  > /sys/kernel/debug/tracing/events/nvme_complete_rq/enable

- run fstrim

- after the fstrim failure is triggered, disable the nvme io trace & post the log:

	#echo 0  > /sys/kernel/debug/tracing/events/nvme_setup_cmd/enable
	#echo 0  > /sys/kernel/debug/tracing/events/nvme_complete_rq/enable

	#cp	/sys/kernel/debug/tracing/trace /root/nvme_io_trace.log



thanks,
Ming
