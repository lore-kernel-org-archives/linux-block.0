Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37CDC4724C
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 19:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEBC12073E
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 19:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="A3F/LQbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgD3TCg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgD3TCf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 15:02:35 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC2FC035494
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2020 12:02:35 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so2617810plo.7
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2020 12:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FROnpU6hscmOBgzrwIxZlxfKUCyrhuvr2YDegRzZaNw=;
        b=A3F/LQbRdACepkwO1i+2YyWP0vZ9DwbpFD0EsAGWjdGXCDqkF+6CFnmDOjEI4Idvn2
         nKMmT/Uho58m4ha5YaQYqeJPaEtOsW8JKmRdTyGEux0fTjlL3e7m7KdZSvN2IjMyt8Gi
         XCIK2MAt+FgjJbJzpPRvi3r5Y3hK3du605UmqGcb9oiw8KR1N13g0jhu18wXKddxwHSh
         Vz38clGHYXQH+hQJedUbTxDPdllleLIrdAZDSjISzWmN/1BmwYV3y5lEGOviV5wa3uQB
         WhK0tiEAfKbSpvsqlJnRs1Gda5vFl2V2TsSmDFUc8RQezymK6/rHHpW1IcnptPLiIeDZ
         DrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FROnpU6hscmOBgzrwIxZlxfKUCyrhuvr2YDegRzZaNw=;
        b=JgX0aB8wKXJ8znESA6jeMoD6+LfEt3W1zL7cNUxW3qDNdhbR8Yq+d+vEsNx2EzkOr8
         cQU2mmdtmJWKJ95qq1L1gAse3yninFIMxX40ZyfY+M8ByjXrvuEMjxKUgpRXL43SFxS5
         xUFR8yijHba/NCGtoVNvpT9OMyRvv851WGH0V48S8J1ZoYgow/4y6F7bGF4ne35WP+JG
         RL3JFSazlMR/Df7lm/o1rv5BNUTGANftmm5WOj4WtEdUxUSP4JlLiJUXlk+exSYkFF/u
         R0K4zf5ehVme0TkRijzazBskyPdN5Spy26EEoM74i/I18wOBWlH3IpJ/cVBL8syHqChq
         a+Rg==
X-Gm-Message-State: AGi0PubX2dAP3OdQ4kopVCC15mF2c1d/tOyeGej27RELWp5KXwqCut2D
        VSPr9xb7ZVJo/T105CjEq1JtitKFv00=
X-Google-Smtp-Source: APiQypICIlpvQQSt3u4Du/DNWCbYvbOgwLpbc5FSJ5kkKnVI+IMbO1f01K5xmO3iqEX6KIA/VYvcwA==
X-Received: by 2002:a17:90a:9202:: with SMTP id m2mr246691pjo.109.1588273355039;
        Thu, 30 Apr 2020 12:02:35 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:d243])
        by smtp.gmail.com with ESMTPSA id a23sm442256pfo.145.2020.04.30.12.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:02:33 -0700 (PDT)
Date:   Thu, 30 Apr 2020 12:02:27 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Klaus Jensen <its@irrelevant.dk>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH blktests v3] Fix unintentional skipping of tests
Message-ID: <20200430190227.GA1232639@vader>
References: <20200422074436.376476-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422074436.376476-1-its@irrelevant.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 22, 2020 at 09:44:36AM +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> cd11d001fe86 ("Support skipping tests from test{,_device}()") breaks a
> good handful of tests.
> 
> For example, block/005 uses _test_dev_is_rotational to check if the
> device is rotational and uses the result to size up the fio run. As a
> side-effect, _test_dev_is_rotational also sets SKIP_REASON, which (since
> commit cd11d001fe86) causes the test to print out a "[not run]" even
> through the test actually ran successfully.
> 
> Fix this by renaming the existing helpers to _require_foo (e.g. a
> _require_test_dev_is_rotational) and add the non-_require variant where
> needed.
> 
> Fixes: cd11d001fe86 ("Support skipping tests from test{,_device}()")
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

Thanks! I'll apply this assuming it looks good after a full test run. A
couple of comments below, but I fixed those up.

> ---
> 
> Changes since v2
> ~~~~~~~~~~~~~~~~
> * Fix missing _test_dev -> _require_test_dev in block/003 (Shinichiro)
> * Revert change in block/004 (Shinichiro)
> 
>  check           | 10 ++++------
>  common/iopoll   |  4 ++--
>  common/rc       | 35 ++++++++++++++++++++++++++++-------
>  new             | 12 ++++++------
>  tests/block/003 |  2 +-
>  tests/block/007 |  3 ++-
>  tests/block/011 |  2 +-
>  tests/block/019 |  2 +-
>  tests/nvme/032  |  2 +-
>  tests/nvme/rc   |  4 ++--
>  tests/scsi/006  |  2 +-
>  tests/scsi/rc   |  6 +++---
>  tests/zbd/007   |  2 +-
>  tests/zbd/rc    | 11 +++++++++--
>  14 files changed, 62 insertions(+), 35 deletions(-)
> 
> diff --git a/check b/check
> index 398eca05e3a4..84ec086c408b 100755
> --- a/check
> +++ b/check
> @@ -423,18 +423,16 @@ _call_test() {
>  _test_dev_is_zoned() {
>  	if [[ ! -f "${TEST_DEV_SYSFS}/queue/zoned" ]] ||
>  	      grep -q none "${TEST_DEV_SYSFS}/queue/zoned"; then
> -		SKIP_REASON="${TEST_DEV} is not a zoned block device"
>  		return 1
>  	fi
>  	return 0
>  }

This can be simplified to:

_test_dev_is_zoned() {
	[[ -e "${TEST_DEV_SYSFS}/queue/zoned" &&
	    $(cat "${TEST_DEV_SYSFS}/queue/zoned") != none ]]
}

A few of the other _test_dev helpers can be cleaned up in the same way.
