Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCA1C04AB3
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 08:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB0B21019
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 08:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="DvHdwxZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbfE2II3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 04:08:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45706 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfE2II3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 04:08:29 -0400
Received: by mail-ed1-f65.google.com with SMTP id f20so2283666edt.12
        for <linux-block@vger.kernel.org>; Wed, 29 May 2019 01:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X55S31ao8CfYMehdctXfzJQFFMsU0ZFkppGUTIESvkI=;
        b=DvHdwxZbhyi3JQ17yrFCBVFILG9oxWRqQorXQBbfNMQbnN8YbiVPExbIjs05xuS6s4
         RrvSJHQYAs3QQ+qJk+dZfwVfVVvY+qXkg81SmYNRsZBDBf08Yof2IdKKDkQz21dEy6vm
         L+WXv2nKXsarLezipgqpzLvOPptiHdm7b5gV8jZKlwcVrkXmwf20nNW8i2JmlutHBAn5
         eSQfFQ+Fbv51uy1DIA3WxzijQ4vpMgbugqlk4yAec5p5VRJU8RtVGQRKfcpotEOKIY0d
         k9rsY0qQqW+3hNX/G+FgxYjVDC/mO884jyhyXyIXfMA9+5aUwTsqTA98ncrDK344QAuw
         7mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X55S31ao8CfYMehdctXfzJQFFMsU0ZFkppGUTIESvkI=;
        b=gEyqLvvaawCEXwtkp9Rfv5W+PwmE7Mxt17PL4/pVJi4/GA/uLzUHdl1INt7vHcpR9c
         xRerJj0u51A49ZCs12ZbXwxlkwDM181pT+X1x5g3z8q29bSF/ukY8Szwc5yK5KHrbo0K
         pni0CXX7PQUxSaSKR5RBWqqxqjJVDrgfDYn88e8tiGP4p/t/IVdRPvXzcnnTQAqgv2vB
         8Qa5nZaAqCUQWCyCEXBmnhHB7BOc494xoec5fCVAaM1IRlywHXAP+i4MyQB7Wz+HgZti
         nDMt3xj4FCAyE+iXm7PQ5nFc1hVNW47R4jWZJy1S1JR7M7PIRPUYeg7nY9Q3mEWyiqqU
         evnw==
X-Gm-Message-State: APjAAAU4c0hsVuP4rNPJcvke1bijGfU381sbtEeDnQCgJTcrfdNZbOuq
        PI2Peu4LMR+qvY67QNCouKlCgg==
X-Google-Smtp-Source: APXvYqyxDyVCDea9bDd1l2EC8hcbEtDWlZ8Dk3yuHbGVJvqjuySoL1bR38CeVbp+JazIYUXhPBHnlQ==
X-Received: by 2002:a17:906:6d3:: with SMTP id v19mr69214570ejb.46.1559117307851;
        Wed, 29 May 2019 01:08:27 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id p18sm792916ejr.61.2019.05.29.01.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 01:08:27 -0700 (PDT)
Subject: Re: [PATCH 1/5] lightnvm: Fix uninitialized pointer in
 nvm_remove_tgt()
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Igor Konopko <igor.j.konopko@intel.com>,
        David Howells <dhowells@redhat.com>,
        "Mohit P . Tahiliani" <tahiliani@nitk.edu.in>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Joe Perches <joe@perches.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        linux-afs@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20190528142424.19626-1-geert@linux-m68k.org>
 <20190528142424.19626-2-geert@linux-m68k.org>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <4b666e32-04b6-228a-691d-0745fa48a57f@lightnvm.io>
Date:   Wed, 29 May 2019 10:08:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190528142424.19626-2-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/28/19 4:24 PM, Geert Uytterhoeven wrote:
> With gcc 4.1:
> 
>      drivers/lightnvm/core.c: In function ‘nvm_remove_tgt’:
>      drivers/lightnvm/core.c:510: warning: ‘t’ is used uninitialized in this function
> 
> Indeed, if no NVM devices have been registered, t will be an
> uninitialized pointer, and may be dereferenced later.  A call to
> nvm_remove_tgt() can be triggered from userspace by issuing the
> NVM_DEV_REMOVE ioctl on the lightnvm control device.
> 
> Fix this by preinitializing t to NULL.
> 
> Fixes: 843f2edbdde085b4 ("lightnvm: do not remove instance under global lock")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>   drivers/lightnvm/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 0df7454832efe082..aa017f48eb8c588c 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -492,7 +492,7 @@ static void __nvm_remove_target(struct nvm_target *t, bool graceful)
>    */
>   static int nvm_remove_tgt(struct nvm_ioctl_remove *remove)
>   {
> -	struct nvm_target *t;
> +	struct nvm_target *t = NULL;
>   	struct nvm_dev *dev;
>   
>   	down_read(&nvm_lock);
> 

Thanks Geert. Would you like me to carry the patch?
