Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CB0C27C7A
	for <linux-block@archiver.kernel.org>; Thu, 17 Aug 2023 08:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349106AbjHQIaJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Aug 2023 04:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348931AbjHQI3l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2023 04:29:41 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C6A119
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 01:29:39 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fe1f70a139so17453525e9.0
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 01:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692260977; x=1692865777;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3x3CNCzNbxZSHDixFhOmVHdfhj5Iy+BRTqOQe78zlpw=;
        b=ASdRQG4ZMicXvkWDPI47rYbgW9nadW0WKHMc4i6vj+Pvf9H7nlfHm2LHQZoNoCqK3P
         w5aqcnF6iIQ0Dk1zxz3kWdtqP9kG0352/iF2VKcLKi0aaZF2bFxbAh24IH3BAPl39sZC
         gvF8wSXE2SO5vuVWD20ztq4Ylm25EHxx9kb5sAg6dybNAJFSwV2LQOeRCbYHfaXvRRrS
         wCICXoopg2icibhsmj/17qLabLy5sXnTVNOgUgJxUEecw3sRmX5tsHtxMcKrAC0KKv+Z
         Jx+4Zi/5EtmxYOhjs5kEt/kX374Pzu9+dAkp5G+xMfBIVLA/9ZV9xgmfvUN2+zcS344/
         /i3A==
X-Gm-Message-State: AOJu0Yzc2kvyiMj8foZIV16oZDfF0FHQaQT8fGV22BzRiMz9QkNEuyAF
        5HAaViGasKNKj5nrdUeR0hc=
X-Google-Smtp-Source: AGHT+IGWXhy4lbi7okPqXciO9hZc0y73nSU63Nuqr+nAoHQh83TSV/4sjOZaERQ5EX0fQ2cEmgnGUA==
X-Received: by 2002:a05:600c:474e:b0:3fa:9767:bb0 with SMTP id w14-20020a05600c474e00b003fa97670bb0mr3348206wmo.0.1692260977416;
        Thu, 17 Aug 2023 01:29:37 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k22-20020a7bc416000000b003fe11148055sm2072515wmi.27.2023.08.17.01.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 01:29:36 -0700 (PDT)
Message-ID: <85f074cd-d916-2baf-36bc-05a19384dcce@grimberg.me>
Date:   Thu, 17 Aug 2023 11:29:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH blktests v2 1/2] nvme/rc: fix nvme device readiness check
 after _nvme_connect_subsys
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, Daniel Wagner <dwagner@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
References: <20230817073021.3674602-1-shinichiro.kawasaki@wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230817073021.3674602-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 8/17/23 10:30, Shin'ichiro Kawasaki wrote:
> The helper function _nvme_connect_subsys() creates a nvme device. It may
> take some time after the function call until the device gets ready for
> I/O. So it is expected that the test cases call _find_nvme_dev() after
> _nvme_connect_subsys() before I/O. _find_nvme_dev() returns the path of
> the created device, and it also waits for uuid and wwid sysfs attributes
> of the created device get ready. This wait works as the wait for the
> device I/O readiness.
> 
> However, this wait by _find_nvme_dev() has two problems. The first
> problem is missing call of _find_nvme_dev(). The test case nvme/047
> calls _nvme_connect_subsys() twice, but _find_nvme_dev() is called only
> for the first _nvme_connect_subsys() call. This causes too early I/O to
> the device with tcp transport [1]. Fix this by moving the wait for the
> device readiness from _find_nvme_dev() to _nvme_connect_subsys(). Also
> add --wait-for option to _nvme_connect_subsys(). It allows to skip the
> wait in _nvmet_passthru_target_connect() which has its own wait for
> device readiness.
> 
> The second problem is wrong paths for the sysfs attributes. The paths
> do not include namespace index, so the check for the attributes always
> fail. Still _find_nvme_dev() does 1 second wait and allows the device
> get ready for I/O in most cases, but this is not intended behavior.
> Fix the paths by adding the namespace index.
> 
> On top of the checks for sysfs attributes, add 'udevadm settle' and a
> check for the created device file. These ensures that the create device
> is ready for I/O.
> 
> [1] https://lore.kernel.org/linux-block/CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com/
> 
> Fixes: c766fccf3aff ("Make the NVMe tests more reliable")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> Changes from v1:
> * Added --wait-for option to _nvme_connect_subsys()
> * Added 'udevadm settle' before readiness check
> 
>   tests/nvme/rc | 31 +++++++++++++++++++++++--------
>   1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 0b964e9..797483e 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -428,6 +428,8 @@ _nvme_connect_subsys() {
>   	local keep_alive_tmo=""
>   	local reconnect_delay=""
>   	local ctrl_loss_tmo=""
> +	local wait_for="ns"
> +	local dev i
>   
>   	while [[ $# -gt 0 ]]; do
>   		case $1 in
> @@ -483,6 +485,10 @@ _nvme_connect_subsys() {
>   				ctrl_loss_tmo="$2"
>   				shift 2
>   				;;
> +			--wait-for)
> +				wait_for="$2"
> +				shift 2
> +				;;

I think that it would make better since to reverse the polarity
here.

connect always wait, and tests that actually want to
do some fast stress will choose --nowait.

>   			*)
>   				positional_args+=("$1")
>   				shift
> @@ -532,6 +538,21 @@ _nvme_connect_subsys() {
>   	fi
>   
>   	nvme connect "${ARGS[@]}" 2> /dev/null
> +
> +	# Wait until device file and uuid/wwid sysfs attributes get ready for
> +	# namespace 1.
> +	if [[ ${wait_for} == ns ]]; then
> +		udevadm settle
> +		dev=$(_find_nvme_dev "$subsysnqn")
> +		for ((i = 0; i < 10; i++)); do
> +			if [[ -b /dev/${dev}n1 &&
> +				      -e /sys/block/${dev}n1/uuid &&
> +				      -e /sys/block/${dev}n1/wwid ]]; then
> +				return

What happens if the subsystem does not have any namespaces?
Or what about other namesapces?

Won't it make more sense to inspect the subsys for
expected ns and wait for all?
