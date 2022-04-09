Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDBBC433F5
	for <linux-block@archiver.kernel.org>; Sat,  9 Apr 2022 08:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbiDIIS5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Apr 2022 04:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiDIIS4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Apr 2022 04:18:56 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4794223E3D3
        for <linux-block@vger.kernel.org>; Sat,  9 Apr 2022 01:16:49 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u17-20020a05600c211100b0038eaf4cdaaeso348021wml.1
        for <linux-block@vger.kernel.org>; Sat, 09 Apr 2022 01:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nnj60HFFj8COyd309Q8C6JWWM2qlsDx/H5COLD9jni8=;
        b=Jkup3xP4Pyeoph/uPUgtPXmFRMFfrlm5hI8M1PLvow7rEF2jlyzt31uNDEv/+dW+JO
         rYSLpq2Yog1QOGQgoAygrbvXj6sFx++pyhAQvHDAMKshdH7iIT0fuvN6kY3gUn8o0AwN
         z3obSLhRnQgHu/WM1G3Wp2H23hJcuhD6QosMEYsZjhLlGOgsi/M1RCPmDiq4zuUOdGnw
         cGkIxbFPA1YdoOLzMch9UleiQEefQMk+D0Vi/DUf4NlzSwuE+fMbFL3ySroCUfsvgB9Z
         u6WbS+25xCl9JGJKG8/bZbO3qVAiZsPL2FQlmM3ylaQ/5ohVAA9AbNeujap5pYW7pT3z
         j+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nnj60HFFj8COyd309Q8C6JWWM2qlsDx/H5COLD9jni8=;
        b=G/k0xK2YXLW9yrumcGNbEJb/Y7xyhMR/qrvNlyfIfY55REyTiVKYps43cpqdN5CYNi
         y/bMRpWPla+LtzWM3wWCvlC23UWStZSMvvFIOnewC9ANgxSloB4gZiP1U5pK9Mv1+mIi
         vFjGor2EAu7UrRj/RZccsGx3wC3qK+Yeqvb3ww6ZRJRZ9dlIUJ4ZdJMUTRzqMl1P4dK6
         Py+RzI+0+6XnIrn5hcYNqdnDjsJe1sg73/8UBbRLaSLRaMCA6MujB0TlZFlpgeiqXbj0
         hD29JN1A6lkaDCzMab3Qxl72DG5aax8ks1iiIHvJwiQzSPVvj4SD4Qf1dhk79Kcvp1oR
         wocA==
X-Gm-Message-State: AOAM530jd1DMoHzMtPFfDIXAQqpyY0eaeOOKdjcD4hbBA+UJ6bJExWuB
        C4jepR+SKQXI4WnK+GRMTzEEvw==
X-Google-Smtp-Source: ABdhPJyeRD2BNsre1rwgXFtmHQTdGvTWlL1y11A1d0Mq4HeSv3wo5ybni3Rj4482qnw1KVHVUVztbg==
X-Received: by 2002:a05:600c:384e:b0:38c:9a8a:d205 with SMTP id s14-20020a05600c384e00b0038c9a8ad205mr19829564wmr.44.1649492207835;
        Sat, 09 Apr 2022 01:16:47 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id 185-20020a1c19c2000000b0038a1d06e862sm12440449wmz.14.2022.04.09.01.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 01:16:47 -0700 (PDT)
Date:   Sat, 9 Apr 2022 09:16:45 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Enze Li <lienze@kylinos.cn>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] cdrom: do not print info list when there is no cdrom
 device
Message-ID: <YlFA7USiCtqsFvVD@equinox>
References: <20220408084221.1681592-1-lienze@kylinos.cn>
 <25390602-cfa0-dba3-bfbc-a35ed6b44bcf@kernel.dk>
 <20220409122530.60353fcd@asus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409122530.60353fcd@asus>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 09, 2022 at 12:25:30PM +0800, Enze Li wrote:
> On Fri, 8 Apr 2022 06:34:04 -0600
> Jens Axboe <axboe@kernel.dk> wrote:
> 
> > On 4/8/22 2:42 AM, Enze Li wrote:
> > > There is no need to print a list of cdrom entries with blank info
> > > when no cdrom device exists.  With this patch applied, we get:
> > > 
> > > ================================================
> > > $ cat /proc/sys/dev/cdrom/info
> > > CD-ROM information, Id:cdrom.c 3.20 2003/12/17
> > > 
> > > No device found.
> > > 
> > > ================================================  
> 
> Hi Jens,
> 
> Thanks for your review.
> 
> > 
> > And what did we get before?
> 
> Without the patch, we get:
> 
> ================================================
> $ cat /proc/sys/dev/cdrom/info
> CD-ROM information, Id: cdrom.c 3.20 2003/12/17
> 
> drive name:	
> drive speed:	
> drive # of slots:
> Can close tray:	
> Can open tray:	
> Can lock tray:	
> Can change speed:
> Can select disk:
> Can read multisession:
> Can read MCN:	
> Reports media changed:
> Can play audio:	
> Can write CD-R:	
> Can write CD-RW:
> Can read DVD:	
> Can write DVD-R:
> Can write DVD-RAM:
> Can read MRW:	
> Can write MRW:	
> Can write RAM:	
> 
> 
> ================================================
> 
> > 
> > Will this potentially break applications that parse it?
> > 
> 
> I dunno, is there any way to confirm this thing?  And if this is really
> a possibility, does it mean that we cannot make changes?
> 
Sorry, anything that can be parsed from userspace has the potential to
break userspace applications. For that reason, I would have to say I
don't think this patch is suitable. Sure there are times it's
appropriate to change userspace interfaces, but I'd rather err on the
side of caution here. Thanks for the patch though.

Nacked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
