Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3E1C77B7A
	for <linux-block@archiver.kernel.org>; Sat, 10 Jun 2023 19:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjFJTKa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 10 Jun 2023 15:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjFJTK3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Jun 2023 15:10:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240EF198C
        for <linux-block@vger.kernel.org>; Sat, 10 Jun 2023 12:10:28 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f70fc4682aso20874805e9.1
        for <linux-block@vger.kernel.org>; Sat, 10 Jun 2023 12:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20221208.gappssmtp.com; s=20221208; t=1686424226; x=1689016226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ToU70xJNc8dVh1qfpRh71Sp2N0GShUulo6svA7d/wx8=;
        b=raRFdnf/3fDyvValEjk8CGVxVccMzlji8KBBUbGmqADpWQViYNJJqWd2/0ASgV+zvF
         CoXyYfHXV5b6bAIGkWMBmIP9r/eCNMz+dYjjG81AXKWoX3RC1tl4gbu6XTHqip5E4Pv/
         DyXGxdhRnnvdoIBDHdoqljx5j9y1TbueGUGFF665TGGbqazNs7cIJhqc6WqbWshMAr19
         uOmyTIzIh0K+t2dKvBKWh3PXQmVRV7EA6g8BMdO4+UN7pdUF+hf4d5QtzVsD4ckcoBhV
         BKMOhtvxdVmPSQo4jG0F1Nu2/RRIib/bCnDtDLNfpRATlsZhi1LNRDgq7muk4gv6AS5R
         NEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686424226; x=1689016226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToU70xJNc8dVh1qfpRh71Sp2N0GShUulo6svA7d/wx8=;
        b=UsskdKdFQk7SWSRARzsKeIpWZMciQZ4zyeLOqDTi8LE7kPuL8PDxK8MfPDLm5SrT2t
         sIJi4oZFi7XnKg6k/YZvt84ecl+U1GUWfOQ+JubC70LON9m1cmX1BBFAyRLy2gmVsBbw
         CeHUUEtrjr2aWoSv3oYTF9VRLlqSkel5CLaDWTlTwiRUteELz0SIQYWNmhxxbl/qLCMx
         l2raqrqvgLRYHiAv/elMLYExyblqeqz1PzNjGo71ZQ0l97mAYKc7Fqpk+d1BFz9yo7Gm
         lHct4+iFk/m5Q9aKmEJFC4PT4sRDnflZSZTQGcVBQhA5sQUVDVQ0ulae0pLMFa71eHlI
         t9Dg==
X-Gm-Message-State: AC+VfDxvhEYXBTi+AsGaeygAoL6wg4RCMV4LxkhUdc2lOHFvfZ+lrv5r
        m6GFXnSXizKBZuwbnldxYA8BM0X4HjPLjzNGLpwuwA==
X-Google-Smtp-Source: ACHHUZ6F1rsiYXPHygLcGkoXxY8Z/tI5BXowQ9kkcXf1E/lo0eJX0RYnDBfWdFQZpNX4+ck6GH5kbQ==
X-Received: by 2002:a7b:c40b:0:b0:3f4:27ff:7d48 with SMTP id k11-20020a7bc40b000000b003f427ff7d48mr2970962wmi.19.1686424226504;
        Sat, 10 Jun 2023 12:10:26 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bce0d000000b003f42a75ac2asm6422099wmc.23.2023.06.10.12.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 12:10:25 -0700 (PDT)
Date:   Sat, 10 Jun 2023 20:10:24 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Jordy Zomer <jordyzomer@google.com>
Cc:     linux-kernel@vger.kernel.org, jordyzomer@google.com,
        pawan.kumar.gupta@linux.intel.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/1] cdrom: Fix spectre-v1 gadget
Message-ID: <ZITKoBzJq+Y5Hi9Z@equinox>
References: <20230609131355.71130-1-jordyzomer@google.com>
 <20230609131355.71130-2-jordyzomer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609131355.71130-2-jordyzomer@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 09, 2023 at 01:13:55PM +0000, Jordy Zomer wrote:
> This patch fixes a spectre-v1 gadget in cdrom.
> The gadget could be triggered by,
>  speculatviely bypassing the cdi->capacity check.
> 
> Signed-off-by: Jordy Zomer <jordyzomer@google.com>
> ---
>  drivers/cdrom/cdrom.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 416f723a2dbb..3c349bc0a269 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -233,6 +233,7 @@
>  
>  -------------------------------------------------------------------------*/
>  
> +#include "asm/barrier.h"
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #define REVISION "Revision: 3.20"
> @@ -2329,6 +2330,8 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
>  	if (arg >= cdi->capacity)
>  		return -EINVAL;
>  
> +	arg = array_index_mask_nospec(arg, cdi->capacity);
> +
>  	info = kmalloc(sizeof(*info), GFP_KERNEL);
>  	if (!info)
>  		return -ENOMEM;
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 

Hi Jordy,

Thanks for the patch, much appreciated. Sadly, as Pawan has already
pointed out, array_index_mask_nospec actually changes the behaviour of
this function, such that 'arg' would no longer be an array index.

In addition, it seems to have triggered the kernel test robot with an
alpha build error.

Regards,
Phil
