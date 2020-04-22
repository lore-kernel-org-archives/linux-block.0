Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFA7C5518A
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 07:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A1320738
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 07:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgDVHSK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:18:10 -0400
Received: from charlie.dont.surf ([128.199.63.193]:50382 "EHLO
        charlie.dont.surf" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgDVHSK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 03:18:10 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net [80.167.98.190])
        by charlie.dont.surf (Postfix) with ESMTPSA id 772F6BF5D9;
        Wed, 22 Apr 2020 07:18:08 +0000 (UTC)
Date:   Wed, 22 Apr 2020 09:18:05 +0200
From:   Klaus Birkelund Jensen <its@irrelevant.dk>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH blktests v2] Fix unintentional skipping of tests
Message-ID: <20200422071805.a6sunwaqb2uf6rfa@apples.localdomain>
References: <20200421073321.92302-1-its@irrelevant.dk>
 <20200422011250.bsl5epjclhri4fqd@shindev.dhcp.fujisawa.hgst.com>
 <20200422051300.w2efeam752fa56ew@apples.localdomain>
 <20200422052949.z4pcqzhvgtpaqmhl@apples.localdomain>
 <20200422064924.3f57azcl6tsdlhsk@shindev.dhcp.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422064924.3f57azcl6tsdlhsk@shindev.dhcp.fujisawa.hgst.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 22 06:49, Shinichiro Kawasaki wrote:
> On Apr 22, 2020 / 07:29, Klaus Birkelund Jensen wrote:
> > On Apr 22 07:13, Klaus Birkelund Jensen wrote:
> > > On Apr 22 01:12, Shinichiro Kawasaki wrote:
> > > > On Apr 21, 2020 / 09:33, Klaus Jensen wrote:
> > > > >  
> > > > > -device_requires() {
> > > > > -	! _test_dev_is_zoned || _have_fio_zbd_zonemode
> > > > > -}
> > > > > -
> > > > >  test_device() {
> > > > >  	echo "Running ${TEST_NAME}"
> > > > >  
> > > > > @@ -25,6 +21,10 @@ test_device() {
> > > > >  	local zbdmode=""
> > > > >  
> > > > >  	if _test_dev_is_zoned; then
> > > > > +		if ! _have_fio_zbd_zonemode; then
> > > > > +			return
> > > > > +		fi
> > > > > +
> > > > 
> > > > This check is equivalent to device_requires() you removed, isn't it?
> > > > If the skip check in test_device() is the last resort, it would be the
> > > > better to check in device_requires(), I think.
> > > > 
> > > 
> > > I did fix something... just not the real problem I think.
> > > 
> > > Negations doesnt really work well in device_requires. If changed to
> > > 
> > >     ! _require_test_dev_is_zoned || _have_fio_zbd_zonemode
> > > 
> > > then, for non-zoned devices, even though device_requires returns 0,
> > > SKIP_REASON ends up being set to "is not a zoned block device" and skips
> > > the test in _call_test due to this.
> > > 
> > > There are two fixes; either we add a _require_test_dev_is_not_zoned
> > > again or put the negated check in an arithmetic context, that is
> > > 
> > >     (( !_require_test_dev_is_zoned )) || _have_fio_zbd_zonemode
> > > 
> > > I think the second option is a hack, so we'd better go with the first
> > > choice.
> > 
> > Doh.
> > 
> > The _is_not_zoned version would of course just cause the test to be
> > skipped for zoned devices instead.
> > 
> > So I actually think my original fix is the best option here.
> 
> Thank you for sharing your thoghts. I agree not to use _is_not_zoned version.
> 
> I think _test_dev_is_zoned in device_requires() does not need to be replaced
> with _require_test_dev_is_zoned. It does not check requirement. It just checks
> if _have_fio_zbd_zonemode check is required or not.

Right, that is a good observation. I'll revert my change there and keep
it as

    device_requires() {
        ! _test_dev_is_zoned || _have_fio_zbd_zonemode
    }


Thanks,
Klaus
