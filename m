Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB388C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 23:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9353221783
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 23:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeLQXQT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 18:16:19 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:34096 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbeLQXQT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 18:16:19 -0500
Received: by mail-pg1-f182.google.com with SMTP id j10so5633720pga.1
        for <linux-block@vger.kernel.org>; Mon, 17 Dec 2018 15:16:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RiYrWm2Y9mMMVjZqfXG1M53iuu2ag4WiVpZFpBzDvo8=;
        b=rfTNlWrsCzIfKL7t0GUy0GuZzc1iYoM8yHScI7sZ1f7nDAAmpvtDDMf03VYDnGjc2K
         zY/ykOH2o2ub7f5Kd6MAG1hwgSX3pw+7cbuTQcGmh+B03SDW3CswpPTbjS+OpZBa6HLS
         LYIEtpPViW5fFT7MLMz3v/XrFjXF7RndEy/XVfaH3LE4BGT7fCk4glzex1LgA/58EOMD
         lCndsFBlHig3uQbjlaugWjEFncfaZHPd8aVbj3vWNM0kXo2e03i66hYxpkcoOjkPRFdf
         KvC0nLMPKBWZtjEBToghVXjJ7sAYfDF5VljtnI9uxfsaYXemWM9ZtH07aNOGXyetjJdq
         Nznw==
X-Gm-Message-State: AA+aEWZMKu4buRhmH5BdL94JV/3N93V39BRXlbbBlU1vVjG9qOwm81iv
        1L4wGrAkMTDGsL0ZPDV/M19DL7iVJj8=
X-Google-Smtp-Source: AFSGD/UKrGbZhSjmnKbJxq7clhin+DoUYG1HylZIhq3SHC9I6as+sDr44gU/Oc6vl/UUdnBpSujgjQ==
X-Received: by 2002:a63:e516:: with SMTP id r22mr14061279pgh.256.1545088578327;
        Mon, 17 Dec 2018 15:16:18 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id u87sm32147516pfi.2.2018.12.17.15.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 15:16:17 -0800 (PST)
Message-ID: <1545088576.185366.443.camel@acm.org>
Subject: Re: Upcoming merge window
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date:   Mon, 17 Dec 2018 15:16:16 -0800
In-Reply-To: <6fe5169f-8032-ac2a-ecb7-f845c56b1d73@kernel.dk>
References: <6fe5169f-8032-ac2a-ecb7-f845c56b1d73@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2018-12-17 at 11:28 -0700, Jens Axboe wrote:
+AD4 As I'm sure you're all aware, the merge window is coming up. This time
+AD4 it happens to coincide with that is a holiday for most. My plan is to
+AD4 send in an EARLY pull request to Linus, Thursday at the latest. If you're
+AD4 sitting on anything that should go in with the initial merge, then I need
+AD4 to have it ASAP.
+AD4 
+AD4 I'll do a later pull about a week in with things that were missed, but
+AD4 I'm really hoping to make that fixes only. Any driver updates etc should
+AD4 go in now.

Hi Jens,

If I run blktests/srp/002 against Linus' master branch then that test passes,
no matter how many times I run that test. If I run that test against your
for-next branch however (commit 6a252f2772c0) then that test hangs. The output
of my list-pending-block-requests script is as follows when the hang occurs:

dm-0
dm-1
dm-1/hctx0/active:0
dm-1/hctx0/flags:alloc+AF8-policy+AD0-FIFO SHOULD+AF8-MERGE+AHw-SG+AF8-MERGE
dm-1/hctx0/tags:nr+AF8-tags+AD0-2048
dm-1/hctx0/tags:nr+AF8-reserved+AF8-tags+AD0-0
dm-1/hctx0/tags:active+AF8-queues+AD0-0
dm-1/hctx0/tags:bitmap+AF8-tags:
dm-1/hctx0/tags:depth+AD0-2048
dm-1/hctx0/tags:busy+AD0-798
dm-1/hctx0/tags:cleared+AD0-935
dm-1/hctx0/tags:bits+AF8-per+AF8-word+AD0-64
dm-1/hctx0/tags:map+AF8-nr+AD0-32
dm-1/hctx0/tags:alloc+AF8-hint+AD0Aew-682, 463, 595, 1923, 841, 628+AH0
dm-1/hctx0/tags:wake+AF8-batch+AD0-8
dm-1/hctx0/tags:wake+AF8-index+AD0-0
dm-1/hctx0/tags:ws+AF8-active+AD0-0
dm-1/hctx0/tags:ws+AD0Aew
dm-1/hctx0/tags:	+AHs.wait+AF8-cnt+AD0-8, .wait+AD0-inactive+AH0,
dm-1/hctx0/tags:	+AHs.wait+AF8-cnt+AD0-8, .wait+AD0-inactive+AH0,
dm-1/hctx0/tags:	+AHs.wait+AF8-cnt+AD0-8, .wait+AD0-inactive+AH0,
dm-1/hctx0/tags:	+AHs.wait+AF8-cnt+AD0-8, .wait+AD0-inactive+AH0,
dm-1/hctx0/tags:	+AHs.wait+AF8-cnt+AD0-8, .wait+AD0-inactive+AH0,
dm-1/hctx0/tags:	+AHs.wait+AF8-cnt+AD0-8, .wait+AD0-inactive+AH0,
dm-1/hctx0/tags:	+AHs.wait+AF8-cnt+AD0-8, .wait+AD0-inactive+AH0,
dm-1/hctx0/tags:	+AHs.wait+AF8-cnt+AD0-8, .wait+AD0-inactive+AH0,
dm-1/hctx0/tags:+AH0
dm-1/hctx0/tags:round+AF8-robin+AD0-0
dm-1/hctx0/tags:min+AF8-shallow+AF8-depth+AD0-4294967295
dm-1/hctx0/tags+AF8-bitmap:00000000: ff03 feff ffff ffff ffff ffff ffff ffff
dm-1/hctx0/tags+AF8-bitmap:00000010: ffff ffff ffff ffff ffff 1f70 0040 0100
dm-1/hctx0/tags+AF8-bitmap:00000020: ffff ffef f7bf ffe7 ffff ffff ffff ffdf
dm-1/hctx0/tags+AF8-bitmap:00000030: ffff ffff ffff ffff ffff ffff ffff ffff
dm-1/hctx0/tags+AF8-bitmap:00000040: ffff ffff ffff ff7f ffff ffff ffff ffff
dm-1/hctx0/tags+AF8-bitmap:00000050: ffff ffff ffff ffff ffff ffff ffff ffff
dm-1/hctx0/tags+AF8-bitmap:00000060: f3ff 1fe0 ffff f19f ffff ffff ffff ffff
dm-1/hctx0/tags+AF8-bitmap:00000070: ffff fff7 9bff fff7 0fec 1300 00e0 1f01
dm-1/hctx0/tags+AF8-bitmap:00000080: ffff ffff ffff e189 ff0f 90ff ffff ffff
dm-1/hctx0/tags+AF8-bitmap:00000090: ffff ffff ffff ffff ffff 0300 00fd 0780
dm-1/hctx0/tags+AF8-bitmap:000000a0: ffff ffff ffff ffff ff0f 0000 0000 5400
dm-1/hctx0/tags+AF8-bitmap:000000b0: ffff ffff ffff ffff ffff ffff ffff ff0f
dm-1/hctx0/tags+AF8-bitmap:000000c0: ffff ffff ffff ff3f ffff ffff ffff 7f1c
dm-1/hctx0/tags+AF8-bitmap:000000d0: ffff ffff ffff ffff ffff ffff ffff ffff
dm-1/hctx0/tags+AF8-bitmap:000000e0: ffff ffff 0f00 0040 1de0 1400 3cdf 0300
dm-1/hctx0/tags+AF8-bitmap:000000f0: ffff ffff 1f1c 7cfb ffff ffff ffff 1fef
dm-1/state:SAME+AF8-COMP+AHw-NONROT+AHw-IO+AF8-STAT+AHw-INIT+AF8-DONE+AHw-STATS+AHw-REGISTERED+AHw-QUIESCED
dm-1/queue/scheduler:+AFs-none+AF0 bfq kyber mq-deadline 
dm-2
loop0
loop1
loop2
loop3
loop4
loop5
loop6
loop7
nullb0
nullb1
sda
sdb
sdc
sdd
sde
sdf
sdg
sdh
vda

Bart.
