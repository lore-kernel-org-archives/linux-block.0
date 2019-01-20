Return-Path: <SRS0=XolY=P5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC0FC282E4
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 07:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A8C20989
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 07:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="tCmZn2Rs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfAUHn5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:43:57 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:36312 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbfAUHn4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 02:43:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id C3796A2A96;
        Sun, 20 Jan 2019 21:28:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1548016131; i=@fjfi.cvut.cz;
        bh=HBL2AncH5x1SXtQ9ePmJvWvkxo2K+9RVzQKNpmFa3BQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=tCmZn2Rs1aRD0W6sIe6kjMDDQOjsRuHcMLUYLWAUZweXqhTGXGSllPJ96CegO+ZOJ
         5+7p7+7oltBlO2Kj6YbU+K9MXAfg2rt9UTh5tFwyk9LowDwY6YIlZmybl0EmY0nFUq
         tehj+KCAmhzgiuMAey7c7zaMcTDE70Pmagy8okYk=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id q_TmkcuJ1vt7; Sun, 20 Jan 2019 21:28:49 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 83139A2A68;
        Sun, 20 Jan 2019 21:28:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 83139A2A68
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 55D246004E; Sun, 20 Jan 2019 21:28:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by linux.fjfi.cvut.cz (Postfix) with ESMTP id 3C69A6002A;
        Sun, 20 Jan 2019 21:28:49 +0100 (CET)
Date:   Sun, 20 Jan 2019 21:28:49 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Scott Bauer <sbauer@plzdonthack.me>
cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH v2 00/16] block: sed-opal: support shadow MBR done flag
 and write
In-Reply-To: <20190119175321.GA15951@hacktheplanet>
Message-ID: <alpine.LRH.2.21.1901202124490.4278@linux.fjfi.cvut.cz>
References: <1547760716-7304-1-git-send-email-zub@linux.fjfi.cvut.cz> <20190119175321.GA15951@hacktheplanet>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 19 Jan 2019, Scott Bauer wrote:

> On Thu, Jan 17, 2019 at 09:31:40PM +0000, David Kozub wrote:
>
>> There is a fork of sed-opal-temp that can use these new IOCTLs.[3] I tested
>> these on Samsung 840 EVO and 850 EVO drives, on x86-64 and arm64 systems.
>
> Generally the series looks fine. Can you please, do some more sanity testing on
> error conditions? Unlock with bad password, try and set up LR with bad PW, or
> too large of a LR, like 242 or something. This series really changes the core
> portion of this driver that essentially makes all this run and it looks like all
> the normal conditions are fine, but im worried about some error conditions.
>
> Resend V3 and I'll do some sanity tests on my end once I find my one nvme drive
> with opal support.

Hi Scott,

Thank you for the review! I will apply your suggestions and then I try to 
do more tests. After that I submit V3.

Best regards,
David
