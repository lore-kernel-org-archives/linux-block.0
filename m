Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5BDC4727D
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 00:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ADC223AA8
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 00:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600734778;
	bh=9iQKPi8cJPw5SWvxhZZXch+CZaHdW8ZYJYD9q25fmC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FR+bltVUMTV6KJl3YTshJZPafg1LtFxDXTJgLJ0RhSYvSchkCicxS/W0j2GHp2sIW
	 P/PIvbboqUavjGJZee7GCWGON82+PeI16+fjCY2Rgm0BL9RfdgOhN8vKmVN5OVplJD
	 dnCTMuAjJaZ+UU9JA8wEX7xoGz2ClXGNH/SSnao8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgIVAc5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 20:32:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbgIVAc5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 20:32:57 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5B1D23A7B;
        Tue, 22 Sep 2020 00:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600734776;
        bh=9iQKPi8cJPw5SWvxhZZXch+CZaHdW8ZYJYD9q25fmC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hk2sRmBVXZ3CSthmSRgdy4u7KSXNJmYwYghxEa/WNY8kRfR8ItEgFa9g0/6FbFu+H
         DwNpHqilQpl/bidklMqrcKRtZF4c2n+AmrHSZjF90kI+m3NZqsxBPQgTNgM1ou/UnB
         nOpII9gaXN/AmRuaNJ2K4yWleJ6EL3veq8Sjo+PQ=
Date:   Mon, 21 Sep 2020 17:32:55 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 2/3] dm: add support for passing through inline crypto
 support
Message-ID: <20200922003255.GC32959@sol.localdomain>
References: <20200909234422.76194-1-satyat@google.com>
 <20200909234422.76194-3-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909234422.76194-3-satyat@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 09, 2020 at 11:44:21PM +0000, Satya Tangirala wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Update the device-mapper core to support exposing the inline crypto
> support of the underlying device(s) through the device-mapper device.
> 
> This works by creating a "passthrough keyslot manager" for the dm
> device, which declares support for encryption settings which all
> underlying devices support.  When a supported setting is used, the bio
> cloning code handles cloning the crypto context to the bios for all the
> underlying devices.  When an unsupported setting is used, the blk-crypto
> fallback is used as usual.
> 
> Crypto support on each underlying device is ignored unless the
> corresponding dm target opts into exposing it.  This is needed because
> for inline crypto to semantically operate on the original bio, the data
> must not be transformed by the dm target.  Thus, targets like dm-linear
> can expose crypto support of the underlying device, but targets like
> dm-crypt can't.  (dm-crypt could use inline crypto itself, though.)
> 
> When a key is evicted from the dm device, it is evicted from all
> underlying devices.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Co-developed-by: Satya Tangirala <satyat@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>

Looks good as far as Satya's changes from my original patch are concerned.

Can the device-mapper maintainers take a look at this?

- Eric
