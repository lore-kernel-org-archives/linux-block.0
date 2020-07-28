Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64499C433E0
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 19:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ADBA2065E
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 19:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="fA7SSZ8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbgG1T3N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:29:13 -0400
Received: from charlie.dont.surf ([128.199.63.193]:58778 "EHLO
        charlie.dont.surf" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729499AbgG1T3M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 15:29:12 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net [80.167.98.190])
        by charlie.dont.surf (Postfix) with ESMTPSA id 2EF07BF884;
        Tue, 28 Jul 2020 19:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
        s=default; t=1595964011;
        bh=NFzVq21e1stFzfjMrIuI1q43hvLfbPzUyxyEI+qN4YI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fA7SSZ8Lz5Aw123chbijrZos1un/4Bqs/2zYHswfDc7a/uf05tzViXBRHjhvTpsR7
         a7VUQmx8fOvHDYJh6YCmnCjjwIReV5dchcMmqjB7XmKwj5c9z6prr4Qlpf+YuF7YVn
         Msub95Bke4FbNY1cjAnfG3v5kkqNqt5WEC9hN/fO1hG4X87ic2OVE7sL8FUP8Kl8Jn
         JBqRvI7kV2dysXcuRUSBVSVRXX++0olVP6Hf90kTc9JgOjuY+auCViOpiXMLfazCqT
         54KHhfrHfGETS86V3K5X03Hj8gliDShXi2RamgUd/LH3ZMXaD8BOjH2+/jHsoeKmtZ
         PDF/VlBq4pG1A==
Date:   Tue, 28 Jul 2020 21:20:09 +0200
From:   Klaus Jensen <its@irrelevant.dk>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 3/5] zbd/004: Check zone boundary writes using
 zones without zone capacity gap
Message-ID: <20200728192009.GC103177@apples.localdomain>
References: <20200728101452.19309-1-shinichiro.kawasaki@wdc.com>
 <20200728101452.19309-4-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728101452.19309-4-shinichiro.kawasaki@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jul 28 19:14, Shin'ichiro Kawasaki wrote:
> The test case zbd/004 checks zone boundary write handling by block layer
> using two contiguous sequential write required zones. This test is valid
> when the first zone has same zone capacity as zone size. However, if the
> zone has zone capacity smaller than zone size, the write in the zone
> beyond zone capacity limit causes write error and the test fails.
> 
> To avoid the write error, find the two zones with first zone that has
> zone capacity same as zone size. If such zones are not found, skip the
> test case.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---

LGTM.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
