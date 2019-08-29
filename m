Return-Path: <SRS0=37yO=WZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ED3C3A59F
	for <linux-block@archiver.kernel.org>; Thu, 29 Aug 2019 12:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C937E2339E
	for <linux-block@archiver.kernel.org>; Thu, 29 Aug 2019 12:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfH2Mv4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Aug 2019 08:51:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47095 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfH2Mvz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Aug 2019 08:51:55 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1i3Ju4-0003sK-7S
        for linux-block@vger.kernel.org; Thu, 29 Aug 2019 12:51:52 +0000
Received: by mail-pl1-f200.google.com with SMTP id p9so1906407pls.18
        for <linux-block@vger.kernel.org>; Thu, 29 Aug 2019 05:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:to:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KXReb5C5sWPqimLePcMad/fib0dL8OM+ZShWXJO5G38=;
        b=PIimw9Vvymg5w8fRk/y8fw3I6TDicylrOF6TnZLqGt+V3RqG7QdI90jaJjpKmFfJFz
         RVr3sSkjPkeCNVAX2Jy4Msb/76nx5rEShlyGugjZ6R1XgOoxNdy317pxW5x8KWU/NDOk
         XBkCtN8jFkXo2NtY7gzRb44EMWAFJyIC2RiKN1ogYnYMYnenng9didZQTN4WVBl8buCG
         Ha5htvUFHWdtNGyv/UaUMTcT0ro0bz9BP1h+fcewDt3HBXG0r4giWAC+igShWki/WxD8
         91wt3WPjIy2wcQJRN/I0Jm8l01rgB91Dv/Rl8KkhYiX3uUa9HwQLOpcc/78sAxZShxa8
         z1Ug==
X-Gm-Message-State: APjAAAWnEVsCMG8RiteCGbFLYH9h8l22wE25ciSZqwNoQBuv5HK9T/75
        OcuXfJ6oCJy5j1DPHWg/0GMBJLq5RRu4uiuXYljC4OxTlLeKjZ6gVuhwGrc5Sttk21LSfnvOl1b
        SneLcW/2IAnDWGSoCD0HVKbYqGWxi/6GovOBZJ+vG
X-Received: by 2002:a62:be04:: with SMTP id l4mr8474335pff.247.1567083110987;
        Thu, 29 Aug 2019 05:51:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw7Y2jT58CB/26WQrcl+PZJqvLOlVtaqsnZLf+cdod1RHd8cPHHCKYYbS46eDmcnXhqa5PRKw==
X-Received: by 2002:a62:be04:: with SMTP id l4mr8474308pff.247.1567083110752;
        Thu, 29 Aug 2019 05:51:50 -0700 (PDT)
Received: from [192.168.1.75] (200-232-247-150.dsl.telesp.net.br. [200.232.247.150])
        by smtp.gmail.com with ESMTPSA id j1sm2797676pfh.174.2019.08.29.05.51.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 05:51:49 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] mdadm: Introduce new array state 'broken' for
 raid0/linear
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, jay.vosburgh@canonical.com,
        liu.song.a23@gmail.com, NeilBrown <neilb@suse.com>,
        Song Liu <songliubraving@fb.com>
References: <20190822161318.26236-1-gpiccoli@canonical.com>
 <20190822161318.26236-2-gpiccoli@canonical.com>
To:     jes.sorensen@gmail.com
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
 mQENBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
 Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
 30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
 irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
 7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
 AAG0LUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPokBNwQT
 AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
 5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
 4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
 q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
 iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
 LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltveuQENBFpVBxcBCADbxD6J
 aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
 pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
 kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
 nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
 bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAGJAR8EGAEIAAkFAlpV
 BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
 1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
 egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
 Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
 kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
 X18zwLgdiQ==
Message-ID: <d8185107-e517-2ce7-7f9b-aa029a97924a@canonical.com>
Date:   Thu, 29 Aug 2019 09:51:38 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822161318.26236-2-gpiccoli@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22/08/2019 13:13, Guilherme G. Piccoli wrote:
> Currently if a md raid0/linear array gets one or more members removed while
> being mounted, kernel keeps showing state 'clean' in the 'array_state'
> sysfs attribute. Despite udev signaling the member device is gone, 'mdadm'
> cannot issue the STOP_ARRAY ioctl successfully, given the array is mounted.
> 
> Nothing else hints that something is wrong (except that the removed devices
> don't show properly in the output of mdadm 'detail' command). There is no
> other property to be checked, and if user is not performing reads/writes
> to the array, even kernel log is quiet and doesn't give a clue about the
> missing member.
> 
> This patch is the mdadm counterpart of kernel new array state 'broken'.
> The 'broken' state mimics the state 'clean' in every aspect, being useful
> only to distinguish if an array has some member missing. All necessary
> paths in mdadm were changed to deal with 'broken' state, and in case the
> tool runs in a kernel that is not updated, it'll work normally, i.e., it
> doesn't require the 'broken' state in order to work.
> Also, this patch changes the way the array state is showed in the 'detail'
> command (for raid0/linear only) - now it takes the 'array_state' sysfs
> attribute into account instead of only rely in the MD_SB_CLEAN flag.
> 
> Cc: NeilBrown <neilb@suse.com>
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
> ---
> 
> v2 -> v3:
> * Nothing changed.
> 
> v1 -> v2:
> * Added handling for md/linear 'broken' state.
> 
> 
>  Detail.c  | 17 +++++++++++++++--
>  Monitor.c |  9 +++++++--
>  maps.c    |  1 +
>  mdadm.h   |  1 +
>  mdmon.h   |  2 +-
>  monitor.c |  4 ++--
>  6 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/Detail.c b/Detail.c
> index ad60434..cc7e9f1 100644
> --- a/Detail.c
> +++ b/Detail.c
> @@ -81,6 +81,7 @@ int Detail(char *dev, struct context *c)
>  	int external;
>  	int inactive;
>  	int is_container = 0;
> +	char arrayst[12] = { 0 }; /* no state is >10 chars currently */
>  
>  	if (fd < 0) {
>  		pr_err("cannot open %s: %s\n",
> @@ -485,9 +486,21 @@ int Detail(char *dev, struct context *c)
>  			else
>  				st = ", degraded";
>  
> +			if (array.state & (1 << MD_SB_CLEAN)) {
> +				if ((array.level == 0) ||
> +				    (array.level == LEVEL_LINEAR))
> +					strncpy(arrayst,
> +						map_num(sysfs_array_states,
> +							sra->array_state),
> +						sizeof(arrayst)-1);
> +				else
> +					strncpy(arrayst, "clean",
> +						sizeof(arrayst)-1);
> +			} else
> +				strncpy(arrayst, "active", sizeof(arrayst)-1);
> +
>  			printf("             State : %s%s%s%s%s%s \n",
> -			       (array.state & (1 << MD_SB_CLEAN)) ?
> -			       "clean" : "active", st,
> +			       arrayst, st,
>  			       (!e || (e->percent < 0 &&
>  				       e->percent != RESYNC_PENDING &&
>  				       e->percent != RESYNC_DELAYED)) ?
> diff --git a/Monitor.c b/Monitor.c
> index 036103f..9fd5406 100644
> --- a/Monitor.c
> +++ b/Monitor.c
> @@ -1055,8 +1055,12 @@ int Wait(char *dev)
>  	}
>  }
>  
> +/* The state "broken" is used only for RAID0/LINEAR - it's the same as
> + * "clean", but used in case the array has one or more members missing.
> + */
> +#define CLEAN_STATES_LAST_POS	5
>  static char *clean_states[] = {
> -	"clear", "inactive", "readonly", "read-auto", "clean", NULL };
> +	"clear", "inactive", "readonly", "read-auto", "clean", "broken", NULL };
>  
>  int WaitClean(char *dev, int verbose)
>  {
> @@ -1116,7 +1120,8 @@ int WaitClean(char *dev, int verbose)
>  			rv = read(state_fd, buf, sizeof(buf));
>  			if (rv < 0)
>  				break;
> -			if (sysfs_match_word(buf, clean_states) <= 4)
> +			if (sysfs_match_word(buf, clean_states)
> +			    <= CLEAN_STATES_LAST_POS)
>  				break;
>  			rv = sysfs_wait(state_fd, &delay);
>  			if (rv < 0 && errno != EINTR)
> diff --git a/maps.c b/maps.c
> index 02a0474..49b7f2c 100644
> --- a/maps.c
> +++ b/maps.c
> @@ -150,6 +150,7 @@ mapping_t sysfs_array_states[] = {
>  	{ "read-auto", ARRAY_READ_AUTO },
>  	{ "clean", ARRAY_CLEAN },
>  	{ "write-pending", ARRAY_WRITE_PENDING },
> +	{ "broken", ARRAY_BROKEN },
>  	{ NULL, ARRAY_UNKNOWN_STATE }
>  };
>  
> diff --git a/mdadm.h b/mdadm.h
> index 43b07d5..c88ceab 100644
> --- a/mdadm.h
> +++ b/mdadm.h
> @@ -373,6 +373,7 @@ struct mdinfo {
>  		ARRAY_ACTIVE,
>  		ARRAY_WRITE_PENDING,
>  		ARRAY_ACTIVE_IDLE,
> +		ARRAY_BROKEN,
>  		ARRAY_UNKNOWN_STATE,
>  	} array_state;
>  	struct md_bb bb;
> diff --git a/mdmon.h b/mdmon.h
> index 818367c..b3d72ac 100644
> --- a/mdmon.h
> +++ b/mdmon.h
> @@ -21,7 +21,7 @@
>  extern const char Name[];
>  
>  enum array_state { clear, inactive, suspended, readonly, read_auto,
> -		   clean, active, write_pending, active_idle, bad_word};
> +		   clean, active, write_pending, active_idle, broken, bad_word};
>  
>  enum sync_action { idle, reshape, resync, recover, check, repair, bad_action };
>  
> diff --git a/monitor.c b/monitor.c
> index 81537ed..e0d3be6 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -26,7 +26,7 @@
>  
>  static char *array_states[] = {
>  	"clear", "inactive", "suspended", "readonly", "read-auto",
> -	"clean", "active", "write-pending", "active-idle", NULL };
> +	"clean", "active", "write-pending", "active-idle", "broken", NULL };
>  static char *sync_actions[] = {
>  	"idle", "reshape", "resync", "recover", "check", "repair", NULL
>  };
> @@ -476,7 +476,7 @@ static int read_and_act(struct active_array *a, fd_set *fds)
>  		a->next_state = clean;
>  		ret |= ARRAY_DIRTY;
>  	}
> -	if (a->curr_state == clean) {
> +	if ((a->curr_state == clean) || (a->curr_state == broken)) {
>  		a->container->ss->set_array_state(a, 1);
>  	}
>  	if (a->curr_state == active ||
> 

Hi Jes, is there anything to improve in this patch? I'll submit V4 soon
to include some suggestions from Song (in the driver), so if you have
suggestions here I could add them to v4.
Thanks in advance,


Guilherme
