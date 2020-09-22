Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6EAC47420
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 14:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 830A92396D
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 14:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="eoc5V0Ez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgIVOog (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Sep 2020 10:44:36 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:49430 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgIVOog (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 10:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1600785876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RcSSmcHxzYVbW8kHAuJX8H1PNlflFvFXWb8s0NzusoU=;
  b=eoc5V0Ez2rXQNb6gXiFc83qc6cChbqseUVhakWA2Ps07HnbdO2fET5dA
   ugNfoei32sJYAsZhf1UWLTD9dkVC8Q8w6mAiV/KC7t9p6O9yiA/viI77j
   wM5KaYQUjud4n7Nscv6Jmu89nC9tjcTQhxMc/r488sDzlAspLcSkjvBKd
   M=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: XBD6INUP8oBB9liQ4LNYA9/wjid0L5qc9+S+Bj5nj22SvUqrjbiv48aVimliGuo4XW45YOe/L8
 kvrGTtwLMBVAB31ShknBlbTGD2gxUQer/zSePc1LKBaUZHM/uEasP72Qb8HwHwgY/E5VM6i2Io
 rXaIG+OVHtmTnzVViuN5kGLgdOX4r5J/USOqp0/qpHsJpcB5c9M0VOEKy8Ifi1MjqDY4Chd/xv
 SdSjiKwB+Ed+Y3eIGopfcVhKMQUl2FtcgVa2gNNC51rZu/16YrVYRWR2I7/hxEwgKWgD+Y9Osz
 0F4=
X-SBRS: 2.7
X-MesageID: 27271375
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,291,1596513600"; 
   d="scan'208";a="27271375"
Date:   Tue, 22 Sep 2020 16:44:25 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
CC:     SeongJae Park <sjpark@amazon.com>, <konrad.wilk@oracle.com>,
        SeongJae Park <sjpark@amazon.de>, <axboe@kernel.dk>,
        <aliguori@amazon.com>, <amit@kernel.org>, <mheyne@amazon.de>,
        <pdurrant@amazon.co.uk>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] xen-blkfront: Apply changed parameter name to the
 document
Message-ID: <20200922144425.GL19254@Air-de-Roger>
References: <20200922141549.26154-1-sjpark@amazon.com>
 <20200922141549.26154-4-sjpark@amazon.com>
 <0171c36f-138b-8f53-7cb7-3b753c7f23dd@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0171c36f-138b-8f53-7cb7-3b753c7f23dd@suse.com>
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 FTLPEX02CL06.citrite.net (10.13.108.179)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 22, 2020 at 04:27:39PM +0200, Jürgen Groß wrote:
> On 22.09.20 16:15, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > Commit 14e710fe7897 ("xen-blkfront: rename indirect descriptor
> > parameter") changed the name of the module parameter for the maximum
> > amount of segments in indirect requests but missed updating the
> > document.  This commit updates the document.
> > 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>

Does this need to be backported to stable branches?

Thanks, Roger.
