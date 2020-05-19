Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DDBC433E1
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 18:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E320220758
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 18:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uv5AlaFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgESS7u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 14:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgESS7u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 14:59:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173ECC08C5C0;
        Tue, 19 May 2020 11:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=yji08Qj3j2iBSbLsrUBloFzlCS8ISnQy1mF6aa7Asmo=; b=Uv5AlaFIYV9rL1YMkp+IpbriSt
        8FwAcSoUV7TAduiwVDGjY7hDXX2rct1ZtwKP/VL/TyhqR+H3bnYw+pcWHIAZH9RPJWp0ehLdnppMS
        SgVtw+mAK+kyBPddMvrCrb4OuMFcMa6LxzuIfX7laXyCPZF5tXyRunLuEQsdzWKvyj67LQgQa4YEd
        EyOKLO+wQiVfdKl/UzrA7spNAfwOVrgfOfHhUoQ0gm3h2FPU66Pb1ZOSRxr1i6wF4z2wWtOfrYNMb
        I78z6CEcOn0oHI+wG68i5cJ+tB1IYjPw5jYwVh6tNvUdoHgUIv650rU4ju1o46tysDH+yW7OOBVad
        fdh5/jjg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jb7Sv-0003qS-II; Tue, 19 May 2020 18:59:49 +0000
Subject: Re: linux-next: Tree for May 19 (block/rnbd/)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20200520040354.3e619918@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <86962843-e786-4a3f-0b85-1e06fbdbd76a@infradead.org>
Date:   Tue, 19 May 2020 11:59:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520040354.3e619918@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/19/20 11:03 AM, Stephen Rothwell wrote:
> Hi all,
> 
> News: there will be no linux-next release tomorrow.
> 
> Changes since 20200518:
> 

seen on i386:

when CONFIG_MODULES is not set/enabled:

../drivers/block/rnbd/rnbd-clt-sysfs.c: In function 'rnbd_clt_remove_dev_symlink':
../drivers/block/rnbd/rnbd-clt-sysfs.c:435:39: error: implicit declaration of function 'module_is_live'; did you mean 'module_driver'? [-Werror=implicit-function-declaration]
  if (strlen(dev->blk_symlink_name) && module_is_live(THIS_MODULE))
                                       ^~~~~~~~~~~~~~
                                       module_driver


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
