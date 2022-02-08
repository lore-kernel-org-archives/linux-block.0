Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8A0C433EF
	for <linux-block@archiver.kernel.org>; Tue,  8 Feb 2022 01:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiBHBUE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241717AbiBHBTu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Feb 2022 20:19:50 -0500
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A3BC03FEEC
        for <linux-block@vger.kernel.org>; Mon,  7 Feb 2022 17:11:14 -0800 (PST)
Received: by mail-pj1-f51.google.com with SMTP id m7so14650987pjk.0
        for <linux-block@vger.kernel.org>; Mon, 07 Feb 2022 17:11:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DJC1AnsaMbaD/5DD0BYKhcTgNVGEdOubQkiRFi9zx/w=;
        b=1L3MmwN2aQQNU28bb79fzkan0wSk0dFFC1Z6vSZ9LlyADgzKndjYLCABep+o9XoQgu
         AOTpaqOfD5oqfjCALmmAqsfjVbLUyFr5gO2KoJNASIyvd/OhkTFBFyI7yf35/xv8IAIu
         dCLKen1WAt506t+L+J9+kgW4/y89TyTWdYiTf8vn3VFmxSLWSlyb3eRhTCOrps+yWiow
         9QL8IqmrsN7OGrJW+WxB2OxRfRS8JM6VVFSEekbqsjQGmpoIcgMxIDtRRrENlXHaSiJD
         sylxaCPIM433VtrACSUMOWhW8RxeMpC6JCPcWElEcNpcqEfZ8nYK2pkcd6TgUWomE+hh
         7rlw==
X-Gm-Message-State: AOAM533d5COREHpEfr/uHsbWaQ5jaWFEFwbbiiNTc0l9AOKww19IkVI6
        seyccz77uPNiBrN6KW2NK7s=
X-Google-Smtp-Source: ABdhPJzFDLfUIKuqP0ULYpujFobmgMCSTin2hhW5e8MbtDYtz3mX6RNRgU3+lPKWplmPAC5SYA6qyA==
X-Received: by 2002:a17:90b:4c91:: with SMTP id my17mr529821pjb.221.1644282626400;
        Mon, 07 Feb 2022 17:10:26 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id c5sm13086817pfc.12.2022.02.07.17.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 17:10:25 -0800 (PST)
Message-ID: <caa2ba82-b3e8-6d5a-d411-241eb147f697@acm.org>
Date:   Mon, 7 Feb 2022 17:10:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] blktests: replace module removal with patient module
 removal
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, dwagner@suse.de,
        osandov@fb.com, linux-block@vger.kernel.org
References: <20211116172926.587062-1-mcgrof@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20211116172926.587062-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/16/21 09:29, Luis Chamberlain wrote:
> for a while now. More wider testig is welcomed.
                               ^^^^^^
                               testing?

> @@ -427,14 +428,8 @@ stop_soft_rdma() {
>   		      echo "$i ..."
>   		      rdma link del "${i}" || echo "Failed to remove ${i}"
>   		done
> -	if ! unload_module rdma_rxe 10; then
> -		echo "Unloading rdma_rxe failed"
> -		return 1
> -	fi
> -	if ! unload_module siw 10; then
> -		echo "Unloading siw failed"
> -		return 1
> -	fi
> +	_patient_rmmod rdma_rxe || return 1
> +	_patient_rmmod 1siw  || return 1

The above clearly has not been tested. There is an easy to spot typo in 
the above change. Please test your changes before publishing these.

> +	if [[ ! -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then

Please use -n instead of ! -z.

> +	if [[ -f /sys/module/$module/refcnt ]]; then

Has this patch been analyzed with 'make check'? I expect checkpatch to 
complain about missing double quotes for the above statement.

> +# Patiently tries to wait to remove a module by ensuring first
      ^^^^^^^^^^^^^^^^^^^^^^^
Tries to wait patiently?

> +	if [[ ! -z $MODPROBE_REMOVE_PATIENT ]]; then

Please use -n instead of ! -z and surround the variable expansion with 
double quotes.

> +	# If we have extra time left. Use the time left to now try to
> +	# persistently remove the module. We do this because although through

What is persistent module removal? Is that perhaps removing a module 
such that it cannot be loaded again?

>   	for m in ib_srpt iscsi_target_mod target_core_pscsi target_core_iblock \
>   			 target_core_file target_core_stgt target_core_user \
>   			 target_core_mod
> -	do
> -		unload_module $m 10 || return $?
> -	done
> +	_patient_rmmod $m || return $1

Please proofread your changes and test your changes before posting 
these. I think that both "do" and "done" should have been preserved above.

Thanks,

Bart.
