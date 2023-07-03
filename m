Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA33AC001B0
	for <linux-block@archiver.kernel.org>; Mon,  3 Jul 2023 14:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjGCOTj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jul 2023 10:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGCOTi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jul 2023 10:19:38 -0400
X-Greylist: delayed 103467 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Jul 2023 07:19:36 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515A2E54;
        Mon,  3 Jul 2023 07:19:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1688393945; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BrTOfOlKBPWc4K7yBdBeJYnEHfycdbapFCQgLLoGE3XFe3IzSb3yKbsIoGbwIrRVT6
    i7J8hSIxLy1/Cv7+0CrfIPeF5/jv+48e/jVXGlTOI2018g2aq9T2CgV1PJYwb/vheAA1
    vFK7OKBl8NZkI3LM3KLDfRXzvq1dgRRIHbFDlu+9+5t5UFrJiyOGlFPqxy/r0g16UDIZ
    yuf47GapLD62Xzu5MhrsEZZYOShnCWfL+jIknprgdpnzj3VS0Lox6xBnW+Cv93V5VS0v
    KX5V16I2iokT+oHxc74E6nkqGgtjah2Fe3RGFAkqClV6YlVi55Lc6cyFP0eo5ce1PmhM
    /7Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1688393945;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aZqkftNwGuiIw+qvH524CVwYcvHNKRAS4n56iIq1vcw=;
    b=ZRtziCBzjcRsbZEVhvuCRvu4OOb9sFb6YhxopTBQUWQsohyNPr2S8PWtrqrSffj4tU
    /D09pichdSN1clItnDXKoKcHDvXzrWbek2qv6sFPPJyliNiNCFubta7KbwzfrFvQfy50
    MhUXSyPpxZVhvZwpdGbsa5vavR9Yt7r3QhC9KD2q7yf20xE8qaGuhinhlaOfVALcNUXE
    wW+kQlcoB8o3ks6VB+TqSUPkacvnXzzgQDdcJMC8I1nF/3OUVbDwCaexXpBxsrWO3IBb
    qvvMwJgQImYC3QimpfaKaDhLP+xOSzx8nuMMhnBkrfaoeNRZ5dHGnyoxY2A/SbIdpi3+
    avLQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1688393945;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aZqkftNwGuiIw+qvH524CVwYcvHNKRAS4n56iIq1vcw=;
    b=XZjO6gm1x0W+ta4vU3k+Z2rY+hOqWYfrRf4Vlu+p32VSDRqWXl/+X119/ZAQbyBvNM
    ooevx2JSf0jGOFGJz7cz7PTemqnBa4b65RGpOaswhwrOC5YrNyA6oArKhXJ3de9b7qqx
    JnSiTYL1pmSz0+Cqw5+kZEk7abeN1usCijwsT4QMbrC+vMOVdKiSYt/PrTF9wnTZb6vW
    0aABdMuOodUY0ykmp1wwvalnOdReXYn8hQWj4vlDUU90jePn0WrQlxyIy/BrCyp1xs1k
    ELwLUEiik1CGE4yIX/KILbFrEXBwDsFt7oDnqWA0Qo+Idz1LoAG8jkKCK1JWetCBxEC/
    FvOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1688393945;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aZqkftNwGuiIw+qvH524CVwYcvHNKRAS4n56iIq1vcw=;
    b=NaABkuKF6mjlHA23pbfoYpK0IUOO3flnFOsyzYy4MJ/KWkE4h+vfUDgSqqRBNMq1rh
    J6OlaYVOx2V+Z2ElYIAw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHvJzedR4hZ0hbXsch5+//XdlPUGFli4Uk5Nm+QSwfKBN9bg="
Received: from [IPV6:2a01:599:a10:1e99:7578:5f56:e200:ca72]
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id N28a51z63EJ4xrt
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 3 Jul 2023 16:19:04 +0200 (CEST)
Message-ID: <947340d9-b640-0910-317b-5c8022220a55@xenosoft.de>
Date:   Mon, 3 Jul 2023 16:19:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-block@vger.kernel.org, Michael Schmitz <schmitzmic@gmail.com>
Cc:     axboe@kernel.dk, linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        hch@lst.de, stable@vger.kernel.org,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christian Zigotzky <info@xenosoft.de>
References: <20230701023524.7434-1-schmitzmic@gmail.com>
 <1885875.tdWV9SEqCh@lichtvoll.de>
 <234f57e7-a35f-4406-35ad-a5b9b49e9a5e@gmail.com>
 <4858801.31r3eYUQgx@lichtvoll.de>
Content-Language: en-US
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <4858801.31r3eYUQgx@lichtvoll.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03.07.23 09:05, Martin Steigerwald wrote:
> So, Christian, unless you can actually enlighten us on a reproducible
> way how users with those setups end up with incorrect partition tables
> like this, I consider this case closed. So far you didn't.
>
> Ciao,
This is a very simple explanation. The first partitions on the RDB disk 
were created with Media Toolbox on OS4.1. After that some additional 
partitions were created with Linux and formatted with ext4.
With the new patched kernel, these can no longer be mounted.

I will try out, if I can correct them with GParted. If it works, then I 
will write some instructions for correcting the partitions via GParted 
for the end users.

GParted is a good tool and suitable for our customers.

I know, this is a very old bug and no one has noticed this one. I have 
not received any error messages because of Linux partitions on RDB disks 
in the last 10 years. I am very happy that this bug is fixed now but we 
have to explain it to our customers why they can't mount their Linux 
partitions on the RDB disk anymore. Booting is of course also affected. 
(Mounting the root partition)

But maybe simple GParted instructions is a good solution.
