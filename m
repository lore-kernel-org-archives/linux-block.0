Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F0FC31E44
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 11:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5852321537
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 11:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="wISeSxpd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfFNLcO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:32:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54608 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfFNLcO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 07:32:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so1973122wme.4
        for <linux-block@vger.kernel.org>; Fri, 14 Jun 2019 04:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8nVWJoeY39suIIZgzswj4aacVGQOKuAApyinJQUDhzc=;
        b=wISeSxpdrtKy6YhXKfQtLkE0GD4kqa0Oy/ToMDpugnOr/zje0ASKBMqfYVlwFAJ7g9
         qXKsNUHtAnPBZUlTbwYFb8A5Qo5d+LAh2OFvLBIJSpsDjbeow7PfCwXVKA9lHIH5pTOl
         ytn8W8OncmzZ4Z/wB28QLVHWqJmr0J74T6Z4BUSEI6y+qhdIoIpAU2TLCtOlufQIPRgd
         pJKe0B4Ub69eLYUbHVNtoo3gERByIWNNtz3dyGwTnmCCRNZjpxm+Rzdhp8ilmSVzo55a
         9FDw6931BM5c3Sb4T7JFrD7hdknJooQM1Ph79P9CZiOO/2NLv+03hFFoAHE266bJexg0
         gU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8nVWJoeY39suIIZgzswj4aacVGQOKuAApyinJQUDhzc=;
        b=BR6E50LB+9AqoMQYKS26I3RpAYz9U2VMkl30mDjjVjMjA2hJMlPwdA8yZe41/GODia
         QK68Lt9Zqby2NiSkRuIW0mAYmqYxE4MikAlEpLtCKYgWSj1LCJdFbycAu4sUyQLqMSPN
         owhhJfwtr4alsIUBEw4Zc8HmI8xRJbGVlpScKRpxiMljaN6/CWodDOgIoqK1FmvI/oX4
         wDq9VKObj9i0vpRDWN3scAESV1+Qw2VXwbSRLIyeYcgwxfGGHOCTG5VK5FICEr3jpY+S
         DTSlcTvWfa+ghPch8HPxSbn30pUoHGC8NeMmQ2rAV4UsNmYh3o2h56n3b9albBJSqYvV
         43Iw==
X-Gm-Message-State: APjAAAUY3FLnU2WKtMJp0KtIS+JTRTGmQ4WFI+5TVWP99Ag6FqrYnsaI
        zu1anptgTNfKvzZMghqoUckCXQ==
X-Google-Smtp-Source: APXvYqx7OtBYzo+1nZZ0vNBobqP0xzx4kNpGJs1wptqcmSRhSZdVRuabeVA+HC8nOOGivJkQ5uKSxw==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr7594045wma.120.1560511931738;
        Fri, 14 Jun 2019 04:32:11 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.239])
        by smtp.gmail.com with ESMTPSA id y133sm4375771wmg.5.2019.06.14.04.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 04:32:11 -0700 (PDT)
Subject: Re: [PATCH 10/10] blkcg: implement BPF_PROG_TYPE_IO_COST
To:     Tejun Heo <tj@kernel.org>, axboe@kernel.dk, newella@fb.com,
        clm@fb.com, josef@toxicpanda.com, dennisz@fb.com,
        lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, bpf@vger.kernel.org
References: <20190614015620.1587672-1-tj@kernel.org>
 <20190614015620.1587672-11-tj@kernel.org>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <e4d1df7b-66bb-061a-8ecb-ff1e5be3ab1d@netronome.com>
Date:   Fri, 14 Jun 2019 12:32:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614015620.1587672-11-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

2019-06-13 18:56 UTC-0700 ~ Tejun Heo <tj@kernel.org>
> Currently, blkcg implements one builtin IO cost model - lienar.  To
> allow customization and experimentation, allow a bpf program to
> override IO cost model.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

[...]

> diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
> index d672d9086fff..beeac8ac48f3 100644
> --- a/tools/bpf/bpftool/feature.c
> +++ b/tools/bpf/bpftool/feature.c
> @@ -383,6 +383,9 @@ static void probe_kernel_image_config(void)
>  		/* bpftilter module with "user mode helper" */
>  		"CONFIG_BPFILTER_UMH",
>  
> +		/* Block */
> +		"CONFIG_BLK_IO_COST",
> +
>  		/* test_bpf module for BPF tests */
>  		"CONFIG_TEST_BPF",
>  	};
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 3d63feb7f852..298e53f35573 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -74,6 +74,7 @@ static const char * const prog_type_name[] = {
>  	[BPF_PROG_TYPE_SK_REUSEPORT]		= "sk_reuseport",
>  	[BPF_PROG_TYPE_FLOW_DISSECTOR]		= "flow_dissector",
>  	[BPF_PROG_TYPE_CGROUP_SYSCTL]		= "cgroup_sysctl",
> +	[BPF_PROG_TYPE_IO_COST]			= "io_cost",
>  };
>  
>  extern const char * const map_type_name[];

Hi Tejun,

Please make sure to update the documentation and bash
completion when adding the new type to bpftool. You
probably want something like the diff below.

Thanks,
Quentin


diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 228a5c863cc7..0ceae71c07a8 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -40,7 +40,7 @@ PROG COMMANDS
 |              **lwt_seg6local** | **sockops** | **sk_skb** | **sk_msg** | **lirc_mode2** |
 |              **cgroup/bind4** | **cgroup/bind6** | **cgroup/post_bind4** | **cgroup/post_bind6** |
 |              **cgroup/connect4** | **cgroup/connect6** | **cgroup/sendmsg4** | **cgroup/sendmsg6** |
-|              **cgroup/sysctl**
+|              **cgroup/sysctl** | **io_cost**
 |      }
 |       *ATTACH_TYPE* := {
 |              **msg_verdict** | **stream_verdict** | **stream_parser** | **flow_dissector**
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 2725e27dfa42..057590611e63 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -378,7 +378,7 @@ _bpftool()
                                 cgroup/connect4 cgroup/connect6 \
                                 cgroup/sendmsg4 cgroup/sendmsg6 \
                                 cgroup/post_bind4 cgroup/post_bind6 \
-                                cgroup/sysctl" -- \
+                                cgroup/sysctl io_cost" -- \
                                                    "$cur" ) )
                             return 0
                             ;;
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 1f209c80d906..6ba1d567bf17 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1070,7 +1070,7 @@ static int do_help(int argc, char **argv)
                "                 sk_reuseport | flow_dissector | cgroup/sysctl |\n"
                "                 cgroup/bind4 | cgroup/bind6 | cgroup/post_bind4 |\n"
                "                 cgroup/post_bind6 | cgroup/connect4 | cgroup/connect6 |\n"
-               "                 cgroup/sendmsg4 | cgroup/sendmsg6 }\n"
+               "                 cgroup/sendmsg4 | cgroup/sendmsg6 | io_cost }\n"
                "       ATTACH_TYPE := { msg_verdict | stream_verdict | stream_parser |\n"
                "                        flow_dissector }\n"
                "       " HELP_SPEC_OPTIONS "\n"
