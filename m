Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91731C6FA82
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 23:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiIBXNp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Sep 2022 19:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIBXNf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Sep 2022 19:13:35 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C510F8ED6
        for <linux-block@vger.kernel.org>; Fri,  2 Sep 2022 16:13:34 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fa2so3334859pjb.2
        for <linux-block@vger.kernel.org>; Fri, 02 Sep 2022 16:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=CXSB5TwQbhvqvewpZ+yLTD4zJlq0TXQvGw/arvh5s4I=;
        b=ydYkR1iRxIzyhVhT6ccZmKXT8Qn8AKHxRsc+Ure00NiYxb45RSanHnq/6xmpSiqXLh
         WjKbAXViH3J8OqdcKTBpOAB4+81FRqfJNIdAXpQH1wxoJEXQNtbL9ZbZr/cC/tu9LIEi
         a4ep0wmMZBQv+w16n4R+mot2yZSZ0+koUZunuvHTOv53RJbiNrrUnmPjcoe8TIN9Zk2y
         YfdlLS4daLj7Lv1RX5dGb2evckuypxQRbZsD1uto9Q/wrSL69HUaPW46aP93RoV80KDA
         6KRIjpfqeL2fC4xTr1HnbhXHTwMDq3K3o+u9dUW3iu0lgltHGkGZC/xtpC2GeCD2ZuAN
         VasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CXSB5TwQbhvqvewpZ+yLTD4zJlq0TXQvGw/arvh5s4I=;
        b=Ey6jadHzDmRsiWcXnJGQBEa9RilMwPJk+PREVVwzcZiAMBnWnkuofuZYRVj+eeMzA0
         fhUTbZlXCQOATQALfxp/PmpKG1Lqenja9FjF4jYOgbdkxA1/+X+B01u44YN5TsCfF+qu
         mhBUTFlEyx9tR6zky70mrifzHyMtDa4So3sXxf5Ji3Tms+NCq87h/9jB0Le6EEpoTJ3L
         zlc88huDtctvc57LdOAdmmedFzWpvm0L0cE0peORq7F629EtHwvKIccrErnDM30EMK9f
         p7dO1p2rwSJWDlJ1ggbxVVc9EmIpyrEvyWykEobKi2JGfJBuIZHjrt0kB8Cm0xK/9FxV
         wQqg==
X-Gm-Message-State: ACgBeo2hYfOMKX6VE9Y8D06UK+If6I5YuQlBKiUZstj0jtCcOqh5vfBu
        XDfI0HVsce9qjGYz31LbEZvAFA==
X-Google-Smtp-Source: AA6agR76BTTkq043ixjnj0rmLmscN3HwyukynuCP9i23k3WkPxF7v9Fg7NyV/p1llvEwU516/dBXpg==
X-Received: by 2002:a17:90a:ec05:b0:1fd:9368:2c8 with SMTP id l5-20020a17090aec0500b001fd936802c8mr7215591pjy.183.1662160413809;
        Fri, 02 Sep 2022 16:13:33 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j8-20020a170903024800b001754cfb5e21sm2243630plh.96.2022.09.02.16.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 16:13:33 -0700 (PDT)
Message-ID: <71945cbe-fe10-2d53-5df7-9f7e6f88a905@kernel.dk>
Date:   Fri, 2 Sep 2022 17:13:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH for-next v3 2/4] io_uring: introduce fixed buffer support
 for io_uring_cmd
Content-Language: en-US
To:     Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
        asml.silence@gmail.com
Cc:     io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        Anuj Gupta <anuj20.g@samsung.com>
References: <20220902151657.10766-1-joshi.k@samsung.com>
 <CGME20220902152709epcas5p1a1bd433cac6040c492e347edae484ca5@epcas5p1.samsung.com>
 <20220902151657.10766-3-joshi.k@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220902151657.10766-3-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/2/22 9:16 AM, Kanchan Joshi wrote:
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index 48e5c70e0baf..c80ce6912d8d 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -56,6 +56,7 @@ struct io_uring_sqe {
>  		__u32		hardlink_flags;
>  		__u32		xattr_flags;
>  		__u32		msg_ring_flags;
> +		__u16		uring_cmd_flags;
>  	};

I don't think there's any point to making that a u16, let's just make it
a u32 since the rest of the flags are like that.

Rest looks good.

-- 
Jens Axboe
