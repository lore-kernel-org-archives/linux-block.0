Return-Path: <SRS0=jnOf=6P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2025FC47254
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 05:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD71208DB
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 05:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgEAFcU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 May 2020 01:32:20 -0400
Received: from charlie.dont.surf ([128.199.63.193]:39668 "EHLO
        charlie.dont.surf" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgEAFcU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 May 2020 01:32:20 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net [80.167.98.190])
        by charlie.dont.surf (Postfix) with ESMTPSA id CA4C9BF66D;
        Fri,  1 May 2020 05:32:17 +0000 (UTC)
Date:   Fri, 1 May 2020 07:32:14 +0200
From:   Klaus Jensen <its@irrelevant.dk>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH blktests v3] Fix unintentional skipping of tests
Message-ID: <20200501053214.in52agk6cmclgcwg@apples.localdomain>
References: <20200422074436.376476-1-its@irrelevant.dk>
 <20200430190227.GA1232639@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200430190227.GA1232639@vader>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 30 12:02, Omar Sandoval wrote:
> On Wed, Apr 22, 2020 at 09:44:36AM +0200, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > cd11d001fe86 ("Support skipping tests from test{,_device}()") breaks a
> > good handful of tests.
> > 
> > For example, block/005 uses _test_dev_is_rotational to check if the
> > device is rotational and uses the result to size up the fio run. As a
> > side-effect, _test_dev_is_rotational also sets SKIP_REASON, which (since
> > commit cd11d001fe86) causes the test to print out a "[not run]" even
> > through the test actually ran successfully.
> > 
> > Fix this by renaming the existing helpers to _require_foo (e.g. a
> > _require_test_dev_is_rotational) and add the non-_require variant where
> > needed.
> > 
> > Fixes: cd11d001fe86 ("Support skipping tests from test{,_device}()")
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> 
> Thanks! I'll apply this assuming it looks good after a full test run. A
> couple of comments below, but I fixed those up.
> 

Good stuff :)

Thanks, Omar!
