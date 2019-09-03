Return-Path: <SRS0=Gq2m=W6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8856AC3A5A5
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 16:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612D323431
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 16:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEAAilDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbfICQMF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:12:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40626 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfICQME (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Sep 2019 12:12:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so9403666pgj.7;
        Tue, 03 Sep 2019 09:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dAdXWGRp8/fowrCm9THOUSCdjWb7mJEYN/KL0laD3uQ=;
        b=jEAAilDcPvvWxYMzUNyq//l5UEQBGUuBmUMPyBxdzYp6fxM1ioPQFZBYgdZ4sqHUR+
         WslXxzCtPFbx1NMFXWrla4MahFqMCyDIbEYZ2E+rfY6xYIFHNsEurXdS/EIRi1tuDB56
         BpWZUdx6tpv1YZZnUkNm5iKS5yjclvnc4uxOBYI4VJJ8nrqRp2zVbwdmjN0QnderQYs1
         C+c9EfiRVVz/3XrPXrh40LxLwtC3mLELyQxZJGbzy7yYhVmULCZBRi2kDXR0iIb861rU
         lpm4pHiwvvuVKY5S9k8qYCYTrRsHZDqogII32yUq7Qbdkv6zIgjZECMLxu3rHO6s3HBQ
         zeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dAdXWGRp8/fowrCm9THOUSCdjWb7mJEYN/KL0laD3uQ=;
        b=qJifALLtpZfZ0m5l0Ly9/WR6g9CxPaJWsmtj/eZ8NLufeh4Ta4kQ6exdUWoMvqC0TP
         5V2L32GaTO1DcnFKjcdS0zMlcF/l6u4nfv234kdn0sJrAHnxm7T6PAsg44TTJNxL1lum
         AQAYRV+b8UMM7hR5emcsHZf5A8bCT+j/evlj06VT0cmiM44A0YBW9HtkyJcv4HOthplN
         D2eWwzq1i2942eIMNnWkgFwFEHG3hegWWZjcQAeTn90ODxP4lOsFwx+odGNoIZk7a/rE
         nKo4e5YVAWMqiAZzquWOmpEraRBfblI/ZYtzmQrk5ug3Um8yhlZ9OwYUJUi2kGo69MJz
         FlbA==
X-Gm-Message-State: APjAAAUeeoVM0mKteBNj8D7ahieczHeqUI+r0wwGsh7aZZGoNOrwfNwu
        rvqENlrSIdYBagRrsMJQcbg=
X-Google-Smtp-Source: APXvYqx2Pzmh4yf64AqdUiNh7C3xwl72iP7Cuip7LJd3dmSUngMqqGhc2zBoeukjefZ5p76EL2axYQ==
X-Received: by 2002:aa7:8ac5:: with SMTP id b5mr39773944pfd.56.1567527123858;
        Tue, 03 Sep 2019 09:12:03 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 127sm1658049pfw.6.2019.09.03.09.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 09:12:03 -0700 (PDT)
Date:   Tue, 3 Sep 2019 09:12:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] usb: Add USB subsystem notifications [ver #7]
Message-ID: <20190903161202.GB22754@roeck-us.net>
References: <20190903125129.GA18838@roeck-us.net>
 <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk>
 <156717350329.2204.7056537095039252263.stgit@warthog.procyon.org.uk>
 <7481.1567526867@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7481.1567526867@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 03, 2019 at 05:07:47PM +0100, David Howells wrote:
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > This added call to usbdev_remove() results in a crash when running
> > the qemu "tosa" emulation. Removing the call fixes the problem.
> 
> Yeah - I'm going to drop the bus notification messages for now.
> 
It is not the bus notification itself causing problems. It is the
call to usbdev_remove().

Guenter
