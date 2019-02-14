Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DB5C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 22:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413AA2175B
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 22:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfBNWU5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:20:57 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40123 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfBNWU5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 17:20:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id h1so3794847pfo.7;
        Thu, 14 Feb 2019 14:20:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eNot59Zih8i505EAGOmjYWHUfqxiPx7YqpG4rUoQO+4=;
        b=J94/WzVMiNb8K4tc786Yl/nFlU/1nlTwFW9r1P+KO0j+vNGwomaSjOoEMb1tLNlYhN
         vXxEVe2okxBOtMLvQ9etIXGB81rHa8EUPn0VRnnVdV9OOBEtHEZZZwuWNJwgNpPLq/3H
         DvB5D7m+TDlpwMsaEYs9nh+RF5/LHCob/UDkGWdDZ8rMFFpCdL+T/U82JSCEsL7etP6s
         AdcwbnuxDHqsy+wBpfz2Fs20LytvnxNW24S+JBbOjif6+tmD2o8kFwB90AmM9uAuIXEp
         Br3qO2AzWn4cvbiTxk+Ufbvn9mDuNHR0BP44Tsmcaoguk6YHczv/OVa6PPAWaR4nEF0C
         BvRA==
X-Gm-Message-State: AHQUAubRLTXgJ/zG1dJX3uuRYLSXlrsNZEmsrUnZOK1pnoRe4tSZvXWl
        cUI80AbCIg9XjTxTTSdCPNw=
X-Google-Smtp-Source: AHgI3IbluXoMEHV5qIeLZ+YyBArKSnhftdeYQ0VpclbcJaq8a9uwemhvcNA5EKMwA8N2GkxiCDJfWA==
X-Received: by 2002:a62:1f5c:: with SMTP id f89mr6506775pff.137.1550182856358;
        Thu, 14 Feb 2019 14:20:56 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id b24sm4521620pfe.136.2019.02.14.14.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 14:20:55 -0800 (PST)
Message-ID: <1550182854.31902.75.camel@acm.org>
Subject: Re: KASAN warning in bt_for_each
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>, Evan Green <evgreen@google.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 14 Feb 2019 14:20:54 -0800
In-Reply-To: <a1471a88-f45b-885d-b62e-a3c539c6583d@kernel.dk>
References: <CAE=gft4_WiL87FtZnVmZok+oXPjK=GUb5tDUPGQFijddrB0Pbg@mail.gmail.com>
         <1550172827.93548.5.camel@acm.org>
         <CAE=gft5GR1xEM1gNQjMyo_wfhs_JUAc2AUHHk5qr36EjaWv1hg@mail.gmail.com>
         <a1471a88-f45b-885d-b62e-a3c539c6583d@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-02-14 at 13:50 -0700, Jens Axboe wrote:
+AD4 On 2/14/19 1:45 PM, Evan Green wrote:
+AD4 +AD4 On Thu, Feb 14, 2019 at 11:33 AM Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4 wrote:
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 On Thu, 2019-02-14 at 10:04 -0800, Evan Green wrote:
+AD4 +AD4 +AD4 +AD4 Greetings, block experts+ACE
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 I'm trying to track down a KASAN warning I'm seeing in our downstream
+AD4 +AD4 +AD4 +AD4 4.19 kernel, and I could use a little help. The warning looks like
+AD4 +AD4 +AD4 +AD4 this:
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 +AFs  224.564894+AF0 BUG: KASAN: use-after-free in bt+AF8-for+AF8-each+-0x1ac/0x28c
+AD4 +AD4 +AD4 +AD4 +AFs  224.571195+AF0 Read of size 8 at addr ffffffc17c621340 by task fio/3851
+AD4 +AD4 +AD4 +AD4 +AFs  224.577745+AF0
+AD4 +AD4 +AD4 +AD4 +AFs  224.579320+AF0 CPU: 2 PID: 3851 Comm: fio Tainted: G W 4.19.16 +ACM-398
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Please have a look at this e-mail thread:
+AD4 +AD4 +AD4 https://lore.kernel.org/linux-block/1545261885.185366.488.camel+AEA-acm.org/
+AD4 +AD4 
+AD4 +AD4 Oh, yep, that's totally it. Did that patch make it in anywhere?
+AD4 
+AD4 It didn't, since I didn't get any response to it.

I will have a look. Sorry that I had dropped the ball on that patch.

Bart.
