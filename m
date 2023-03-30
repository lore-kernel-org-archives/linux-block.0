Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEBBC7619A
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 19:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjC3TvA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 15:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjC3Tu7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 15:50:59 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0777DFF19
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 12:50:56 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 469B35C0061;
        Thu, 30 Mar 2023 15:50:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 30 Mar 2023 15:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680205856; x=1680292256; bh=0v
        imBmm2Am/TLqz8rMtJyhFPYD+SHUU8+le2YWXMgJo=; b=lsG8L2k+QgSQpsks4o
        +TrEgumtshzxc0uN0cqaB7DJFL+6bdRYwr0HgDcmjaaW6yaA26fyG5sDMmN1zprb
        gekafqmyYE9E7at3r32ngujp/cxaGvHV82cVB1z1WKxQSCsy2b5dqq5V83Qk/7cD
        iU6rNcFFlObsDOGBILkoawlf9nJFqCK7GyAXhbyXSw8T+5jydrl15FQY1cDy8tSG
        9KYqLPf0ic2hK5/ZTOZR6jAdon9IzKsPUP/XK7qNQRGug0vYeTw/FP/Cpl8byxxX
        9gBWkgwo/fyuuQSimxcRLxuHAEaDYaQmHchTnmPJA4zPl/4R91vN2HDuEICyqMqt
        bLvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680205856; x=1680292256; bh=0vimBmm2Am/TL
        qz8rMtJyhFPYD+SHUU8+le2YWXMgJo=; b=EJxhzoxAPq1V7MVN4GguhSS87C1MM
        8lzqANO9FoPh+1bnZCFlLkA7ZkqOhq6yhQ+kRBApC3sFbZJxhWOuTCfUJn7nA+xl
        G+UxuxXXaoSc/xzlf8VAl46LgsYVoZvY3cc4D9CU1oxRfRWU2o7bU62GmmQJGYnC
        GWEmOwJfQBcPfW4O4DNNkbNJgWp4zIBUqPGmhgbRPjYOQUxaQzyYzdfPA4wlS6fk
        HzrSpE0jGVnrRgbfRa0+jUicl+0/Uza3hjg6TJnsxqGfqeyerPKJzAJz1B6VDRH2
        7Bd8V1z5+FIPn1mxJuOFEI2WM8oH8yf9aSduwVohriWs+wMr6Km2wcu0A==
X-ME-Sender: <xms:H-glZHoOvjncZ2DBhG8HEKXtHOhFY6yR6La0xGQF4tvNnpx8B8vq5g>
    <xme:H-glZBriW8Px8HuMiyPNR1pCubyUw4mMi6l7v-rMyuJ2oP-BLsUuz2z2kSoTA_QXq
    MA8UKGihctp4xBCzQ>
X-ME-Received: <xmr:H-glZEP5mq7KUke5sUt9OFkyERxnJxOpLkkgtYG7V54fiP8tqH88x08URKGg7qvFq5SIBYBaiKgx4zr3Lf42vAaTraJBkdXY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehledgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheptehlhihs
    shgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepje
    egjeegteekjeevfeeukedvfedthfelleeuudehjeeiueehhfehgeehtdejtdejnecuffho
    mhgrihhnpehgihhtqdhstghmrdgtohhmpdhgihhthhhusgdrtghomhdpkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    hhhisegrlhihshhsrgdrihhs
X-ME-Proxy: <xmx:H-glZK6_lbyZQ8a3OtnyjGfv6AWs2FSjyDhhZSxRfVYWCSRqqyUBcw>
    <xmx:H-glZG61pKpd8NW7p1BILOw3T5bPJxbi0ufDwnR_xMk_MCAtgfpiEg>
    <xmx:H-glZCiwcMlEEfK9rzLSYShMviC_G7OTs7LRsv_mgGJFLefiBYn1UQ>
    <xmx:IOglZISBDrwWcjS-Gqv4zid8Dx6WbCWLotu_BJFI_GtqeQ9y66nYng>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Mar 2023 15:50:55 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
        id CBA232414; Thu, 30 Mar 2023 19:50:53 +0000 (UTC)
Date:   Thu, 30 Mar 2023 19:50:53 +0000
From:   Alyssa Ross <hi@alyssa.is>
To:     kernel test robot <lkp@intel.com>
Cc:     chaitanyak@nvidia.com,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        oe-kbuild-all@lists.linux.dev, axboe@kernel.dk, hch@lst.de,
        linux-block@vger.kernel.org
Subject: LKP kernel test robot and blktests patches
Message-ID: <20230330195053.hpb4upyezb7uy2dw@x220>
References: <20230330160247.16030-1-hi@alyssa.is>
 <202303310316.QS2vADHM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zu5tgpfp2prkujrp"
Content-Disposition: inline
In-Reply-To: <202303310316.QS2vADHM-lkp@intel.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--zu5tgpfp2prkujrp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi LKP team,

blktests's CONTRIBUTING.md says that blktests patches should be
sent either on GitHub, or to linux-block with the "PATCH blktests"
subject prefix.  I just sent such a patch, and because it was just
adding a file, the kernel test robot happily applied and tested it as if
it was a kernel patch, which naturally resulted in it finding problems.

Maybe the kernel test robot should skip patches starting with
"[PATCH blktests]"?

n Fri, Mar 31, 2023 at 03:22:28AM +0800, kernel test robot wrote:
> Hi Alyssa,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v6.3-rc4 next-20230330]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Alyssa-Ross/loop-009-add-test-for-loop-partition-uvents/20230331-001157
> patch link:    https://lore.kernel.org/r/20230330160247.16030-1-hi%40alyssa.is
> patch subject: [PATCH blktests] loop/009: add test for loop partition uvents
> reproduce:
>         scripts/spdxcheck.py
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303310316.QS2vADHM-lkp@intel.com/
>
> spdxcheck warnings: (new ones prefixed by >>)
> >> tests/loop/009: 2:27 Invalid License ID: GPL-3.0+
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests

--zu5tgpfp2prkujrp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmQl6BwACgkQ+dvtSFmy
ccCk5hAAqFSWG19aTQ06rDtTDP9iihziv9tcfDbZHZa/IPrJ/1ycJSJlR1wn71y3
Ik/oOgS8wSPmQXN9/HfqrJlst6rANsfEAb1eSwu0Iql3gc5sXMfBsxXG/QjZhBb2
MVxEo9DSUOxnlkfjQJxT7Wku99soLAkdgYao5RQ8aJuoo0pNB1/TKvWC/iDMs4nB
rUMxRHe+1TsZnNv6COQUihRED+rejzQw+SDM+oUr76aaNlhZlRMFy2Anxl1Fm3g9
Fd5aJcpP5RQ7UmOzT26LU/FqYiwmR35fdDTPd6qep63+r7PAqVmOpq0WvX7WepEV
UCOxkj5LAJPQrnolE+H9ixH7BlcTRRf6V/H8Uq1wfceNPpvsTgiKNlXir07Eocgr
Z79P/HX+pOd5soFYN7ADJFfeNGkcqyt6sBZrkfdaDkyk/eHdd1rPkq2M5BbEMzzo
U/RceYS7WGq3397LVUFUt0BAVvAr7NsgCt2280/JINCcAGdDsMBEwuNeHr2rKBfy
mxnoViNHmqC2Cv2ltro/Gu8RKJHk/aneRbMoHl/rvvTTM72UG8zItpuR+XwsPEwi
xrl3k20SF5qmCH0x01Gm8lB/s1uelvJa9qAI+FiVdc5n+yaV5tepSgoGsSv1K/WS
9Nz9+3x7BwOAcofWNscmn6IMVK/NdJKnEBUhLmFjXD7bI75WMTs=
=RO3L
-----END PGP SIGNATURE-----

--zu5tgpfp2prkujrp--
