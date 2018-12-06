Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B593C64EB1
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A5920868
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="A7Uh5ZvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A5920868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbeLFQsx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:48:53 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39992 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeLFQr7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 11:47:59 -0500
Received: by mail-it1-f196.google.com with SMTP id h193so2465532ita.5
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 08:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n0zC4mow3EkDr35CCd61zQ5yq5iwS8th4MfG94MVmOk=;
        b=A7Uh5ZvGql6MJMeqIkiqgBeSWbWtRqZOBCgOeG17VhqnD/DApUPlJF4X2MKii2h4nh
         zzhEL5iSnSgjRyzxKY1aLME3lK0UXREPr4Co0H0bCYrgmln5wqip00ofK4T1LXmTm5+W
         zryrq1DH/UD7gvhpZTJcWITLxedUyT269PbuL6t6ybUNND1LEfRjd7nXYZtc/0XIDG5Z
         JhoLyVh9GlskWeWIKUpO/dLgFog3dAiYQLxkCclFXGsHuF0n4MApuworxS6VQYuWRKUA
         e9TRxQb30NhXhaNB8+b601ONOYERhgLQMRn/Ey2fLOTjDhIAtuETN2VKMmCgK6/s3H0R
         qO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n0zC4mow3EkDr35CCd61zQ5yq5iwS8th4MfG94MVmOk=;
        b=U44XOiMQ0BTpi/76GuJ5fHp46zbkUrZ6W+u9mKs6smnesB3v4h8XIOKr0ak9aw2SX5
         UrP9ATDsg3WpwILigV6vyGdENeLTOoM6bRUWEPuxRLV5hV+8rtm1Wr0Pj5fe/zIkjP0i
         zlXUW+vgLgI18qftEddpPIlSpaDksPYTX4+eyjYCoydrQIMYnbEYDdvARH2ufpM6qPiw
         aHXr1vw5Ns2pnnr3/DavlDA0WzbVr6ZAqGKq6hDNbdp8WiEj+h/hfzIWvINIWxdJ1Tyn
         z2piiMwk2wHpBw65XodmCVst2wQ/dHR0c2fS9i0n+32C3UG8JHxdJWM1KVw29s0c1nxU
         /2Ew==
X-Gm-Message-State: AA+aEWY41W3t6rKTIGQp4ztgbk91kR840r7KR+leOOhxc1RnuNAZiXls
        awQDLXLVbGz7+AmKuZiyo/SDuQ==
X-Google-Smtp-Source: AFSGD/VDl9UwNmxYgPNEbmfcwVmAGKyuXKCNc9a/UZ8MtUpFG3bvTmtT7ohvGGjrSOW7Q1lLrBW6tw==
X-Received: by 2002:a24:1490:: with SMTP id 138mr22962844itg.101.1544114878497;
        Thu, 06 Dec 2018 08:47:58 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v19sm615414itb.0.2018.12.06.08.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 08:47:57 -0800 (PST)
Subject: Re: for-next branch and throttling
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Dennis Zhou <dennis@kernel.org>
References: <1544114355.185366.245.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <67664f40-acb2-15fe-d2dd-daa574a37477@kernel.dk>
Date:   Thu, 6 Dec 2018 09:47:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544114355.185366.245.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 9:39 AM, Bart Van Assche wrote:
> Hello,
> 
> If I merge Jens' for-next branch with Linus' master branch and boot the
> resulting kernel in a VM then the call trace shown below appears. This call
> trace does not appear when building and booting the code from Linus' master
> branch. Is this perhaps a regression?
> 
> WARNING: CPU: 1 PID: 257 at block/blk-throttle.c:2128 blk_throtl_bio+0xc00/0x1120
> Modules linked in: floppy(+) virtio_blk(+) virtio_net net_failover failover i2c_piix4 pata_acpi
> CPU: 1 PID: 257 Comm: systemd-udevd Not tainted 4.20.0-rc5-dbg+ #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> RIP: 0010:blk_throtl_bio+0xc00/0x1120

It's some over-zealous rcu removal, simple fix is coming. CC Dennis.

-- 
Jens Axboe

