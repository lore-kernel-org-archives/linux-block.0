Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C63C4332F
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 21:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiKPVaz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiKPV3M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 16:29:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D97C5D6AD
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 13:29:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 424CCB81EC5
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 21:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90214C433C1;
        Wed, 16 Nov 2022 21:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668634148;
        bh=hfk2U3Zg0mxrKDwiD9st5z8DcULXjwa2zyNexGKFV3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ch9Zfo0KJCucAoNdl9pmAx1xFyzU7rKwRs2fLi2dFOL0JRFuxqDdyCoeGfD8vSjZ8
         bI0Tn3vQJfrLVKfvbO08j9l4hk3rb8/cZg0LGK0Q99mkIL6SWTnWI7zG+nFfWA6i+7
         sa25bqCvJ3yXXRB+11ZQ0hoAFmtrwKELbi4QFU2E=
Date:   Wed, 16 Nov 2022 13:29:07 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-mm@kvack.org, axboe@kernel.dk, clm@meta.com,
        willy@infradead.org, hch@infradead.org
Subject: Re: [RFC PATCH v3 06/14] mm: split off __bdi_set_max_ratio()
 function
Message-Id: <20221116132907.4cc1a0881432e140c8b81bda@linux-foundation.org>
In-Reply-To: <20221024190603.3987969-7-shr@devkernel.io>
References: <20221024190603.3987969-1-shr@devkernel.io>
        <20221024190603.3987969-7-shr@devkernel.io>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 24 Oct 2022 12:05:55 -0700 Stefan Roesch <shr@devkernel.io> wrote:

> This splits off the __bdi_set_max_ratio() function from the

nit: it saves a few electrons to use "foo()" in place of "the foo()
function".  No information is lost in this substitution.


