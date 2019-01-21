Return-Path: <SRS0=XolY=P5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82511C2F3A0
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 14:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5380520861
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 14:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfAUORd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:17:33 -0500
Received: from gateway20.websitewelcome.com ([192.185.4.169]:29416 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730530AbfAUNuY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 08:50:24 -0500
X-Greylist: delayed 1304 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jan 2019 08:50:23 EST
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id D99AD400D1908
        for <linux-block@vger.kernel.org>; Mon, 21 Jan 2019 07:28:38 -0600 (CST)
Received: from gator4095.hostgator.com ([192.185.4.107])
        by cmsmtp with SMTP
        id lZd0gSR8c2qH7lZd0g4vs2; Mon, 21 Jan 2019 07:28:38 -0600
X-Authority-Reason: nr=8
Received: from [192.185.4.107] (port=17485 helo=webmail.electricjungle.org)
        by gator4095.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <candyangel@electricjungle.org>)
        id 1glZd0-000vEy-K2; Mon, 21 Jan 2019 07:28:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 21 Jan 2019 07:28:38 -0600
From:   candyangel@electricjungle.org
To:     linux-block@vger.kernel.org
Cc:     oleksandr@natalenko.name
Subject: I/O stall since 4.19.1
Message-ID: <efcb7530827f9a9bd1ae9324bc33cae8@electricjungle.org>
X-Sender: candyangel@electricjungle.org
User-Agent: Roundcube Webmail/1.3.3
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4095.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - electricjungle.org
X-BWhitelist: no
X-Source-IP: 192.185.4.107
X-Source-L: Yes
X-Exim-ID: 1glZd0-000vEy-K2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (webmail.electricjungle.org) [192.185.4.107]:17485
X-Source-Auth: candyangel@electricjungle.org
X-Email-Count: 2
X-Source-Cap: eHllbTt4eWVtO2dhdG9yNDA5NS5ob3N0Z2F0b3IuY29t
X-Local-Domain: yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Heyas,

I've discovered an issue when upgrading my sisters computer where
kernels 4.19.1 and above (up to 4.20.3, the latest I could test with)
result in intermittent stalling of the machine as each process gets
"stuck" waiting on disk I/O, even though there is no actual disk
activity occuring (no activity in iotop, HDD LED is off and the disks
are making no seek noise).

4.19.1 seems to have stalls of around 3 minutes and 4.20.3 would stall
for upwards of 20 minutes (if it ever recovered at all).

I'm unable to specifically trigger the stall, though in my testing it
manifests within 3 hours of boot during light usage (browsing the
internet, using Discord).

I logged an issue on bugzilla which contains stack trace of blocked
processes during a stall:
https://bugzilla.kernel.org/show_bug.cgi?id=202353.

As mentioned there, I can reliably start and stop the behaviour by
changing kernel versions, so I don't believe it is a hardware issue.
The disk setup is 2 SATA HDDs with RAID10f2 and ext4 partitions.

I'm happy to try and do what I can to help isolate the issue, but please
bear in mind that I don't have much experience debugging kernel issues!

Thanks for your time,
CandyAngel
