Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A4AC43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 00:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35A52080D
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 00:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="OZVRC1zc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeLSAqg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 19:46:36 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46208 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbeLSAqg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 19:46:36 -0500
Received: by mail-io1-f67.google.com with SMTP id v10so14227693ios.13
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 16:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bb/3N2NJRdmf2bTw4nyOG/OZC3joMMw7W5hlm3NnTZo=;
        b=OZVRC1zc0a6nrOM7HtaKNXyRstsNJjoVRcBBc/C4Lrysr3jjYkw3W7e6zsNpM2WaYw
         LiRoipDLYS5ckcpt4/+UlDHemkQtObwXWyfQoeQ+YD3sK+poqJKD/vg2vrN7CXyhazBU
         ZdXGGWyRRoVMu47Fq41bjMsk1YCuan0N6dxyzP9nnLYmgFZ1VhK+olqNodmIiqA9gE2h
         HQjlCTfew7/ZShTthIbcc8RdfMREbgJqT0idpk2Jd1KS2JtAOuLb/95TRncBck2pSfOF
         RyVZyFLZQTxpIx4mWkz6xQaZhKNmzlDAVEzYQQvXTLAbYnU9Z8EG/csemB2TLecKj2IA
         dHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bb/3N2NJRdmf2bTw4nyOG/OZC3joMMw7W5hlm3NnTZo=;
        b=AKfMTKPR5Zfr95W/HmT+yLpQIOk0553NKd1zLBsvQG9MVG8aUIjOeFsEtpuggtM4+8
         uG/Xqsk6uxJ/ES5SfWfywNs9DGLEA5kdsKFIvv4L4Gb8KHFE546mrv200uGQsYSYFEqB
         bMY1c9FWva5xJw15xiwvIWF1f45FhNmn0Vi6vpVBzi9ehWqxAXHFQ29/YvDBSPG2etww
         donIT/ZnxF8So7nxvxO0qRgHRPCqrbHQUUePmRzJ2HhoOz7a97zoKG3zHfCBkEoIDuj1
         eQUuoFzRVgADECbubH7Dx6+vRtCQw0bY9yASjymDB2aMSGGUGC0B3cJPulUCdhlV55UY
         pisw==
X-Gm-Message-State: AA+aEWZzA2K9C+nAZ/3wke2W8J8TTuXFyMLBej1aMYsAAypMsDHEKcx1
        TJ5lcygqfyY9e0zKKiKv3WfFSeLYjKVHiw==
X-Google-Smtp-Source: AFSGD/Wg14smh4BgEZ6TusZfao9Gej30WFG2Qh5cq/UN0Ck0+sjWcF7FahrV3VydoYZqahrrgEik5w==
X-Received: by 2002:a6b:3b4f:: with SMTP id i76mr17182939ioa.266.1545180394692;
        Tue, 18 Dec 2018 16:46:34 -0800 (PST)
Received: from vader ([2620:10d:c090:200::7:ffa])
        by smtp.gmail.com with ESMTPSA id v4sm3140382itv.20.2018.12.18.16.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 16:46:34 -0800 (PST)
Date:   Tue, 18 Dec 2018 16:46:33 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org, osandov@fb.com
Subject: Re: [PATCH] blktests: test turning wbt on and off
Message-ID: <20181219004633.GD12683@vader>
References: <20181212215853.29855-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212215853.29855-1-josef@toxicpanda.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 12, 2018 at 04:58:53PM -0500, Josef Bacik wrote:
> There have been a few issues with turning wbt on and off while IO is in
> flight, so add a test that just does some random rw IO and has a
> background thread that toggles wbt on and off.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  tests/block/027     | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/block/027.out |  2 ++
>  2 files changed, 49 insertions(+)
>  create mode 100755 tests/block/027
>  create mode 100644 tests/block/027.out
> 
> diff --git a/tests/block/027 b/tests/block/027
> new file mode 100755
> index 000000000000..dce6431172a8
> --- /dev/null
> +++ b/tests/block/027
> @@ -0,0 +1,47 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2018 Josef Bacik
> +#
> +# Turn wbt on and off in the background while writing to the disk to verify
> +# there's no races in the inflight counter manipulation
> +
> +. tests/block/rc
> +
> +DESCRIPTION="run a read workload and write workload together with wbt"
> +
> +requires() {
> +	_have_fio && _have_program jq

This test doesn't use jq.

> +}
> +
> +device_requires() {
> +	_test_dev_supports_wbt
> +}
> +
> +toggle_wbt() {
> +	while true
> +	do
> +		_test_dev_queue_set wbt_lat_usec 0
> +		sleep 1
> +		_test_dev_queue_set wbt_lat_usec 1
> +		sleep 1			
Trailing whitespace.   ^^^^^^^^^^^^^^^^^

> +	done
> +}
> +
> +test_device() {

Since this is entirely in the block layer, this test doesn't seem like
it needs a real device. Can it use null_blk instead? See block/006 for
an example.

> +	echo "Running ${TEST_NAME}"
> +
> +	local wbt_setting toggle_pid
> +	wbt_setting=$(_test_dev_queue_get wbt_lat_usec)
> +
> +	(toggle_wbt &)
> +	toggle_pid=$!
> +
> +	_run_fio --name randrw --numjobs=8 --runtime=30 --randseed=12345 \
> +		--ioengine=psync --readwrite=randrw --filename="$TEST_DEV"

If you leave off --runtime=30 here, _run_fio will automatically use the
configured TIMEOUT, and you can make this a TIMED test (i.e., set
TIMED=1 after DESCRIPTION=).

> +	kill $toggle_pid > /dev/null 2>&1
> +	wait
> +	_test_dev_queue_set wbt_lat_usec "$wbt_setting"
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/block/027.out b/tests/block/027.out
> new file mode 100644
> index 000000000000..b03498fbc763
> --- /dev/null
> +++ b/tests/block/027.out
> @@ -0,0 +1,2 @@
> +Running block/027
> +Test complete
> -- 
> 2.14.3
> 
