Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD75C43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 01:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3809022507
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 01:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iXVSsNlF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3809022507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbeKMLw3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:52:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33568 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMLw3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 06:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xyhICmvadfrnShpHejrsXRbuDAeIhRd9ectqbLmueZA=; b=iXVSsNlFsAiI3I4EY907z5TGd
        aOIvOLQbdGrhToOPGeoryVn3DnrPvG/oqNqfIZK8Dx30KeC6Dr29RXFhGXj1aGDmZMYrRr7sKhiEO
        I74K7SDSKHUxA8XwkgAz0LW8vDQa5ZGJi6EYatt9h9w+nXW789bALNxTNYGyKjBgGN5ynOWxen9BS
        cEsesZJw0KP0jpqizcK48bJwAFBlybbApjIPVBAg9+BlnWLhCX9DxSUaev0aQhsovEAyf3ci2/4wn
        7bSt/VoeK6Qju5dgIQ+ZiGZJG2N3oJeA5pWQjAq2MMzPey+ytgwkaWRNFwMWB2tvGx4TMrHgBieBl
        RLxZ/Dzvg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMNwJ-0003Sl-Ch; Tue, 13 Nov 2018 01:56:27 +0000
Date:   Mon, 12 Nov 2018 17:56:27 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 01/12] kernfs: add function to find kernfs_node without
 increasing ref counter
Message-ID: <20181113015627.GI21824@bombadil.infradead.org>
References: <20181112095632.69114-1-paolo.valente@linaro.org>
 <20181112095632.69114-2-paolo.valente@linaro.org>
 <20181112122840.GA1429@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112122840.GA1429@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 12, 2018 at 04:28:40AM -0800, Greg Kroah-Hartman wrote:
> On Mon, Nov 12, 2018 at 10:56:21AM +0100, Paolo Valente wrote:
> > From: Angelo Ruocco <angeloruocco90@gmail.com>
> > 
> > The kernfs pseudo file system doesn't export any function to only find
> > a node by name, without also getting a reference on it.
> > But in some cases it is useful to just locate a kernfs node, while
> > using it or not depends on some other condition.
> > 
> > This commit adds a function to just look for a node, without getting
> > a reference on it.
> 
> Eeek, that sounds really bad.  So you save off a pointer to something,
> and have no idea if that pointer now really is valid or not?  It can
> instantly disappear right afterwards.
> 
> This feels wrong, what is the problem of having a properly reference
> counted object passed back to you that you have to create a dangerous
> function like this?

I agree with Greg, this function is dangerous.  What's wrong with using
find_get and then doing a put once you successfully take it over, or
fail to take it over?
