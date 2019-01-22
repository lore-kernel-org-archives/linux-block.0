Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC964C282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 23:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE5B20870
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 23:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="XSWFj9zh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbfAVXY7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:24:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42651 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfAVXY6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 18:24:58 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so127086plp.9
        for <linux-block@vger.kernel.org>; Tue, 22 Jan 2019 15:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KcQ135T5PCHgc64d/8py49rHZtUQ2yRKGNuA6zbkROA=;
        b=XSWFj9zhfb+ahQe7OuW1tQ3QIZb6BZxLwEC2u2q+hv5qu2+ywVyp9DojYUJugg+kKz
         luGzV2RTrfwF1xjSJmRYTz/FvW6ysvrherX3LTsoxb2my+pozyefSZVbWBFMJVZiBMvW
         B2RhuAtxOf7v2d4Ke9SdPlYiErlOL36tzaJsPtvCSzd0BQhQwQ+Vym0oQ+Fb3MiDTTzA
         ZVFtlNf5T1iwzfBz0SPhzP3n95oWnsvq/xLWkK806iDlEOrMlP6iekoDvnqFKaGq5Www
         FNdjp5Dj4CKeDf6aJ9zuMIKK7n9igyh6tMshu2rTpvbFF+LqR9dM1L3KJgi+8Sepsk5t
         65VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KcQ135T5PCHgc64d/8py49rHZtUQ2yRKGNuA6zbkROA=;
        b=UnNjY6rgEYxmU5OUQ4Y4msOIbd7JSaw92C5+5HRMgrXIJXJ5HY9rrQbJtPf1XIPBp4
         TMfc69Rqqoqv29xQoe06c/0nSxD+5/IeXUb0+NO8WDuH3f4Cdq/tguQ0gIrTWseF2f5N
         Rn2xfK505SbiCkGhdHF9nNo74jnci08Y+1rFqgHUsGIl3BOyCFRJje5kFCkMxZ1c7Vjt
         D8ag4TkXpi5sLoENWluFq8JbCGrEw2FpwFXIP2C72gwzQVay/DsgbZ8Go4JL+8H98uFA
         MlKKCqa7bnkfZrYhp8ieKbqZ6Lq0XFxHrBZQ8Tw1xhUDKJQkdB2NGO51h2XdNvmbOZJg
         7NsA==
X-Gm-Message-State: AJcUuket3yzWvOi1uF5qzrxhLkyTADWBtaLvZyk0Tg3PYQidf0H3Q6F3
        s6nvAF19vobwt2khUC9AIOd0eg==
X-Google-Smtp-Source: ALg8bN5kil9jJMs2ovbW6FYHbe5aqokyTKCkWRo7nUkXyddLiEHBNyQIru9FvuwPOReIlRld7M8wsA==
X-Received: by 2002:a17:902:1122:: with SMTP id d31mr36073349pla.246.1548199497883;
        Tue, 22 Jan 2019 15:24:57 -0800 (PST)
Received: from vader ([2620:10d:c090:200::7:930f])
        by smtp.gmail.com with ESMTPSA id s84sm34314185pfi.15.2019.01.22.15.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 15:24:57 -0800 (PST)
Date:   Tue, 22 Jan 2019 15:24:56 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: 028: block integrity funtion test
Message-ID: <20190122232456.GB5884@vader>
References: <20190117034425.18376-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117034425.18376-1-ming.lei@redhat.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 17, 2019 at 11:44:25AM +0800, Ming Lei wrote:
> Use scsi_debug's dif/dix to cover block layer's integrity function
> test, then it can serve as block integrity regeression test.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  tests/block/028     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  tests/block/028.out |  9 +++++++++
>  2 files changed, 51 insertions(+)
>  create mode 100755 tests/block/028
>  create mode 100644 tests/block/028.out
> 
> diff --git a/tests/block/028 b/tests/block/028
> new file mode 100755
> index 000000000000..9b76b93d9eb6
> --- /dev/null
> +++ b/tests/block/028
> @@ -0,0 +1,42 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2019 Ming Lei <ming.lei@redhat.com>
> +#
> +# Test basic DIF/DIX test. Regression test for commit 7809167da5c86fd6
> +# ("block: don't lose track of REQ_INTEGRITY flag")
> +
> +. tests/block/rc
> +. common/scsi_debug
> +
> +DESCRIPTION="do scsi_debug dif/dix function test"
> +
> +requires() {
> +	_have_scsi_debug
> +}
> +
> +test_pi() {
> +	if ! _init_scsi_debug dev_size_mb=128 dix=$1 dif=$2 delay=0; then

Missing quoting here and elsewhere. `make check` will catch this.

> +		return 1
> +	fi
> +
> +	local dev="/dev/${SCSI_DEBUG_DEVICES[0]}"
> +	local nr_sects=`blockdev --getsz $dev`

$() instead of ``, please.

> +
> +	dd if=/dev/urandom of=$dev bs=512 count=$nr_sects status=none
> +	dd if=$dev of=/dev/null bs=512 status=none
> +
> +	_exit_scsi_debug
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"

dix and dif should be local.

Fixed and applied, thanks Ming.

> +	for ((dix = 0; dix <= 1; dix++)); do
> +		for ((dif = 0; dif <= 3; dif++)); do
> +			test_pi $dix $dif
> +			echo "Test(dix:$dix dif:$dif) complete"
> +		done
> +	done
> +
> +	rm -f "$FULL"
> +}
> diff --git a/tests/block/028.out b/tests/block/028.out
> new file mode 100644
> index 000000000000..d2512334b9f5
> --- /dev/null
> +++ b/tests/block/028.out
> @@ -0,0 +1,9 @@
> +Running block/028
> +Test(dix:0 dif:0) complete
> +Test(dix:0 dif:1) complete
> +Test(dix:0 dif:2) complete
> +Test(dix:0 dif:3) complete
> +Test(dix:1 dif:0) complete
> +Test(dix:1 dif:1) complete
> +Test(dix:1 dif:2) complete
> +Test(dix:1 dif:3) complete
> -- 
> 2.9.5
> 
