Return-Path: <SRS0=uOpu=37=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99F8C35242
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 22:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B346D2073C
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 22:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="A61MxXQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgBKWGJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:06:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37026 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgBKWGJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 17:06:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so130594pfn.4
        for <linux-block@vger.kernel.org>; Tue, 11 Feb 2020 14:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IiHOtEqkxLxGB5XiLWazg4eRRf+uxs2RVq0bp45DM6A=;
        b=A61MxXQOjmtcC3XssK2NzBZbaHBWHW0KQLXfw2SxI9IBnHWl6yMMb3aWrhKfZWCzUG
         B2FJjLGbUApmmkWXfqNREziqpFoTtsWydep5pFw/LqLBcFHf/2Uv/0oHid9qtN+uTzAO
         bAH9nuGqlYx09oLt7Pr/sYGY6zt5e+UCx3ZVP/idaOiv7JnZye+lnapwTPr4c7AT0rov
         GFai3YawQ6nbYcocgyKkkkNuhSoVfZFikUlu7q2Behn7KEUMZd9+eNbimZHakF7KxBnG
         YffbqgE+9OgmSpmWlD6WBfa0SAKGznZvELdYIbaQ3aZpfpVSP+dx7XksS9ouNL3FV5tr
         SjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IiHOtEqkxLxGB5XiLWazg4eRRf+uxs2RVq0bp45DM6A=;
        b=RsH8AuNZi3RgDcogrqrts4ylFb+Nv2ZWFv4BrVp8M1z2737sMEWNj+aYcHsM41IrLm
         V/cHi3mzjM1ObRk2KVgBdBLkDsUqnDw4rQKFy+O8ByKeNCvnZRfyKRSKrXrhgCrzB5ov
         7uB02HOdx4/PQpQXz4oleeaNFcYt4BipaCePxDVqjA1k9stqBA4KzESlO9KTFaBz5yiv
         d6A7zmb0xXUsastAiCVrhOilQkJYVC0vvWVMJc9lJSFWW162t4QkfV/Z5WhkKf+2RUBa
         H0TaEL/Um6tNbcCev8jAlJOWMqcAN42T3v3nUnh3SiPaoGpemreIxFYJAn6LF8o/MZ3i
         uv8A==
X-Gm-Message-State: APjAAAVldO9jsq/VB+OeyVGNSCxmxxC8LHNSFlcQ5xp0SbfSYs8HY/Ds
        fgZdj5aR6TWDeNfDB7MStBKwoA==
X-Google-Smtp-Source: APXvYqyVDUpFjyQiBWQu5KUOyTxnIpoNmUJbQ2q3rWg9s/bSe2Tvd2RSDtOYCjbJZxvxlMpuNyEDsQ==
X-Received: by 2002:a63:d441:: with SMTP id i1mr5470131pgj.426.1581458768093;
        Tue, 11 Feb 2020 14:06:08 -0800 (PST)
Received: from vader ([2620:10d:c090:200::1:80ca])
        by smtp.gmail.com with ESMTPSA id c19sm5842425pfc.144.2020.02.11.14.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 14:06:07 -0800 (PST)
Date:   Tue, 11 Feb 2020 14:06:07 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/5 blktests] nvme: make new testcases backward compatible
Message-ID: <20200211220607.GF100751@vader>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
 <20200129232921.11771-6-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129232921.11771-6-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 29, 2020 at 03:29:21PM -0800, Chaitanya Kulkarni wrote:
> This patch makes newly added testcases backward compatible with
> right value setting into the SKIP_REASON variable.

Oh! These should be part of the new tests from the start. Please
reorganize the series.

> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  tests/nvme/033 | 60 +++++++++++++++++++++++++++-----------------------
>  tests/nvme/034 | 59 ++++++++++++++++++++++++++-----------------------
>  tests/nvme/rc  | 27 +++++++++++++++++------
>  3 files changed, 83 insertions(+), 63 deletions(-)
> 
> diff --git a/tests/nvme/033 b/tests/nvme/033
> index 97eba7f..db5ded3 100755
> --- a/tests/nvme/033
> +++ b/tests/nvme/033
> @@ -9,49 +9,53 @@
>  DESCRIPTION="Test NVMeOF target cntlid[min|max] attributes"
>  QUICK=1
>  
> +PORT=""
> +NVMEDEV=""
> +LOOP_DEV=""
> +FILE_PATH="$TMPDIR/img"
> +SUBSYS_NAME="blktests-subsystem-1"
> +
> +_have_cid_min_max()
> +{
> +	local cid_min=14
> +	local cid_max=15
> +
> +	_setup_nvmet
> +	truncate -s 1G "${FILE_PATH}"
> +	LOOP_DEV="$(losetup -f --show "${FILE_PATH}")"
> +
> +	# we can only know skip reason when we create a subsys
> +	 _create_nvmet_subsystem "${SUBSYS_NAME}" "${LOOP_DEV}" \
> +		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" ${cid_min} ${cid_max}
> +}
> +
>  requires() {
>  	_have_program nvme && _have_modules loop nvme-loop nvmet && \
> -		_have_configfs
> +		_have_configfs && _have_cid_min_max
>  }
>  
>  test() {
>  	echo "Running ${TEST_NAME}"
>  
> -	_setup_nvmet
> -
> -	local port
> -	local nvmedev
> -	local loop_dev
> -	local cid_min=14
> -	local cid_max=15
> -	local file_path="$TMPDIR/img"
> -	local subsys_name="blktests-subsystem-1"
> -
> -	truncate -s 1G "${file_path}"
> -
> -	loop_dev="$(losetup -f --show "${file_path}")"
> -
> -	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
> -		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" ${cid_min} ${cid_max}
> -	port="$(_create_nvmet_port "loop")"
> -	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
> +	PORT="$(_create_nvmet_port "loop")"
> +	_add_nvmet_subsys_to_port "${PORT}" "${SUBSYS_NAME}"
>  
> -	nvme connect -t loop -n "${subsys_name}"
> +	nvme connect -t loop -n "${SUBSYS_NAME}"
>  
>  	udevadm settle
>  
> -	nvmedev="$(_find_nvme_loop_dev)"
> -	nvme id-ctrl /dev/${nvmedev}n1 | grep cntlid | tr -s ' ' ' '
> +	NVMEDEV="$(_find_nvme_loop_dev)"
> +	nvme id-ctrl /dev/${NVMEDEV}n1 | grep cntlid | tr -s ' ' ' '
>  
> -	nvme disconnect -n "${subsys_name}"
> +	nvme disconnect -n "${SUBSYS_NAME}"
>  
> -	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
> -	_remove_nvmet_subsystem "${subsys_name}"
> -	_remove_nvmet_port "${port}"
> +	_remove_nvmet_subsystem_from_port "${PORT}" "${SUBSYS_NAME}"
> +	_remove_nvmet_subsystem "${SUBSYS_NAME}"
> +	_remove_nvmet_port "${PORT}"
>  
> -	losetup -d "${loop_dev}"
> +	losetup -d "${LOOP_DEV}"
>  
> -	rm "${file_path}"
> +	rm "${FILE_PATH}"
>  
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/034 b/tests/nvme/034
> index 1a55ff9..39d833f 100755
> --- a/tests/nvme/034
> +++ b/tests/nvme/034
> @@ -9,50 +9,53 @@
>  DESCRIPTION="Test NVMeOF target model attribute"
>  QUICK=1
>  
> +PORT=""
> +NVMEDEV=""
> +LOOP_DEV=""
> +FILE_PATH="$TMPDIR/img"
> +SUBSYS_NAME="blktests-subsystem-1"
> +
> +_have_model()
> +{
> +	local model="test~model"
> +
> +	_setup_nvmet
> +	truncate -s 1G "${FILE_PATH}"
> +	LOOP_DEV="$(losetup -f --show "${FILE_PATH}")"
> +
> +	# we can only know skip reason when we create a subsys
> +	 _create_nvmet_subsystem "${SUBSYS_NAME}" "${LOOP_DEV}" \
> +		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" 14 15 \
> +		${model}
> +}
>  requires() {
>  	_have_program nvme && _have_modules loop nvme-loop nvmet && \
> -		_have_configfs
> +		_have_configfs && _have_model
>  }
>  
>  test() {
>  	echo "Running ${TEST_NAME}"
>  
> -	_setup_nvmet
> -
> -	local port
> -	local result
> -	local nvmedev
> -	local loop_dev
> -	local model="test~model"
> -	local file_path="$TMPDIR/img"
> -	local subsys_name="blktests-subsystem-1"
> -
> -	truncate -s 1G "${file_path}"
> -
> -	loop_dev="$(losetup -f --show "${file_path}")"
> -
> -	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
> -		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" 0 100 ${model}
> -	port="$(_create_nvmet_port "loop")"
> -	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
> +	PORT="$(_create_nvmet_port "loop")"
> +	_add_nvmet_subsys_to_port "${PORT}" "${SUBSYS_NAME}"
>  
> -	nvme connect -t loop -n "${subsys_name}"
> +	nvme connect -t loop -n "${SUBSYS_NAME}"
>  
>  	udevadm settle
>  
> -	nvmedev="$(_find_nvme_loop_dev)"
> -	nvme list | grep ${nvmedev}n1 | grep -q test~model
> +	NVMEDEV="$(_find_nvme_loop_dev)"
> +	nvme list | grep ${NVMEDEV}n1 | grep -q test~model
>  	result=$?
>  
> -	nvme disconnect -n "${subsys_name}"
> +	nvme disconnect -n "${SUBSYS_NAME}"
>  
> -	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
> -	_remove_nvmet_subsystem "${subsys_name}"
> -	_remove_nvmet_port "${port}"
> +	_remove_nvmet_subsystem_from_port "${PORT}" "${SUBSYS_NAME}"
> +	_remove_nvmet_subsystem "${SUBSYS_NAME}"
> +	_remove_nvmet_port "${PORT}"
>  
> -	losetup -d "${loop_dev}"
> +	losetup -d "${LOOP_DEV}"
>  
> -	rm "${file_path}"
> +	rm "${FILE_PATH}"
>  
>  	if [ ${result} -eq 0 ]; then
>  		echo "Test complete"
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 377c7f7..77bafd8 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -128,15 +128,28 @@ _create_nvmet_subsystem() {
>  
>  	mkdir -p "${cfs_path}"
>  	echo 1 > "${cfs_path}/attr_allow_any_host"
> -	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
> -
> -	if [ $# -eq 5 ] && [ -f ${cfs_path}/attr_cntlid_min ]; then
> -		echo ${cntlid_min} > ${cfs_path}/attr_cntlid_min
> -		echo ${cntlid_max} > ${cfs_path}/attr_cntlid_max
> +	if [ $# -eq 5 ]; then
> +		if [ -f ${cfs_path}/attr_cntlid_min ]; then
> +			echo ${cntlid_min} > ${cfs_path}/attr_cntlid_min
> +			echo ${cntlid_max} > ${cfs_path}/attr_cntlid_max
> +		else
> +			SKIP_REASON="attr_cntlid_[min|max] not found"
> +			rmdir "${cfs_path}"
> +			return 1
> +		fi
>  	fi
> -	if [ $# -eq 6 ] && [ -f ${cfs_path}/attr_model ]; then
> -		echo ${model} > ${cfs_path}/attr_model
> +	if [ $# -eq 6 ]; then
> +		if [ -f ${cfs_path}/attr_model ]; then
> +			echo ${model} > ${cfs_path}/attr_model
> +		else
> +			SKIP_REASON="attr_cntlid_model not found"
> +			rmdir "${cfs_path}"
> +			return 1
> +		fi
>  	fi
> +	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
> +
> +	return 0
>  }
>  
>  _remove_nvmet_ns() {
> -- 
> 2.22.1
> 
