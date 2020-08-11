Return-Path: <SRS0=2P2f=BV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265C9C433DF
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 21:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067E920756
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 21:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgHKVan (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:30:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33933 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgHKVam (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 17:30:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id o1so154258plk.1
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2020 14:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wJpZvTjWYQ4GtquYQV60mD7Mq12yiSTpuZSeaMNpyN0=;
        b=b8t8YoFa8w8KpBF/eud/AO0EGuqUdiReGXJP16gHWp7pfd32MiCUIZyRlg2Seo4pzD
         G/BhZn0Q9wwkuvSTrYcBO9ugxlJILaK0bbzNUAha42I1QMB6XXpsMi3AIYKkbInt6XVW
         1uarLCcb3EpfKODAuZLiZAN63dlg63GXgvBA85FNbcIVhFOuGVlUIZDBPy2MhxtGAgBL
         +3CehuftvXzlkknJPdQedRWb0iiIqfdWNxuLeoAD2oef3QpZvia5Cxg/iCrvNkathurg
         nZ+glkk+FLQxHCNkcfKjk4laJkMez+bJfDz0uT3gPeKW6mRzO8v4EaaoQMwpMvHN1MKx
         al1A==
X-Gm-Message-State: AOAM532YOaidDaBb9fSjpzGBIq2ikuQ8Y96MrFwhrANQMGHrMXcWwdEX
        gxrpcCtEnDCvi16wVQ8IdDI=
X-Google-Smtp-Source: ABdhPJxXXgNLIiEH62UdjJYBvzI9CtkwsHM4yswHgb2Zlx3BuYcVW4UtxQ8aYTPYZ40+D6uTq2oKcg==
X-Received: by 2002:a17:90a:6d26:: with SMTP id z35mr2980525pjj.164.1597181441328;
        Tue, 11 Aug 2020 14:30:41 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id o4sm3797557pjs.51.2020.08.11.14.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 14:30:40 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] common: move module_unload to common
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200811210102.194287-1-sagi@grimberg.me>
 <20200811210102.194287-7-sagi@grimberg.me>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <47900df7-e3be-c200-67ff-c9e099cb8aee@acm.org>
Date:   Tue, 11 Aug 2020 14:30:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200811210102.194287-7-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-08-11 14:01, Sagi Grimberg wrote:
> It creates a dependency between multipath-over-rdma
> and test/nvmeof/rc which is not a natural home
> for it. Move it to common helpers.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  common/rc          | 13 +++++++++++++
>  tests/nvmeof-mp/rc | 13 -------------
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 7f02103dc786..cdc0150ea5ea 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -291,3 +291,16 @@ _filter_xfs_io_error() {
>  _uptime_s() {
>  	awk '{ print int($1) }' /proc/uptime
>  }
> +
> +# Arguments: module to unload ($1) and retry count ($2).
> +unload_module() {
> +	local i m=$1 rc=${2:-1}
> +
> +	[ ! -e "/sys/module/$m" ] && return 0
> +	for ((i=rc;i>0;i--)); do
> +		modprobe -r "$m"
> +		[ ! -e "/sys/module/$m" ] && return 0
> +		sleep .1
> +	done
> +	return 1
> +}
> diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
> index e446db297ba1..829b26624b7f 100755
> --- a/tests/nvmeof-mp/rc
> +++ b/tests/nvmeof-mp/rc
> @@ -145,19 +145,6 @@ remove_mpath_devs() {
>  	} &>> "$FULL"
>  }
>  
> -# Arguments: module to unload ($1) and retry count ($2).
> -unload_module() {
> -	local i m=$1 rc=${2:-1}
> -
> -	[ ! -e "/sys/module/$m" ] && return 0
> -	for ((i=rc;i>0;i--)); do
> -		modprobe -r "$m"
> -		[ ! -e "/sys/module/$m" ] && return 0
> -		sleep .1
> -	done
> -	return 1
> -}
> -
>  start_nvme_client() {
>  	modprobe nvme-core dyndbg=+pmf &&
>  		modprobe nvme dyndbg=+pmf &&
> 

Hi Sagi,

I think there is another copy of unload_module() in tests/srp/rc. How about
also removing that copy?

Thanks,

Bart.
