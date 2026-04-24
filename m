Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E27F2BD59C
	for <linux-block@vger.kernel.org>; Fri, 24 Apr 2026 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777016463; cv=pass; b=q3euTMPipXso98WqQeuL352yfcekQDDMK6XPrl/lAvZtCTIjXhP0+88gKvkjjWuVzggP6lfVQii9c/iFoFtYuLaSk8wj1o+OOfrujlmPHU0+q1/XaGCEaH2O/eZigtSNVgpAEewVy+PNzx/WpC7HTc2lUkKzJBHreFHya2EX5Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777016463; c=relaxed/simple;
	bh=1rwbJM462mkcs2a4PZtcLRIS3iii9rEHHa3eCFevBXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8D3GSZic9LIsrsLzh0u5+fRjE20wWuPRHpS1OUyTv+0br0wb1y2Lu2CrwCicdU1+uES7cYwta0u6rJunhIDOqUtMF7hy+HvWsYljiOcy2uEecoYthk8GXaqntpThcEEmLBMmugws78MW8ljEfjbQuJEBPpGYWQUFx4djCusNS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4vQcc1/; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4vQcc1/"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79db5e18ac6so90181337b3.1
        for <linux-block@vger.kernel.org>; Fri, 24 Apr 2026 00:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777016461; cv=none;
        d=google.com; s=arc-20240605;
        b=eLemanpnqeiFotW0Qb0pbfoZpEKFYh09moDxfWoOmCXPEsu9giR+hXGq6IIB68M3Xs
         bogszxWZMsZQwN2JJIKseZIaudIwZcjUFTPqAZ5PyPFRWzXXebu1qGRt6J/3Wc524/vq
         wHsceG3euyMU65aYLor9CGKwAUo1sKhz/AKOHPBgXAzxNtcuzsl7NO+OXjC+ijT/itJj
         2Q1JHemIlhZ8H8izhD3gxfeeHa9tDN12aOfsswY5LCCld+gClFUlTcOcw06Bu9PkWEXO
         e17zm4Ycz8jmmOgUj1b6xzNSHhR2ZdZOGNS0S6Kjw5gMKBkHcF1eMLjZkpFmWxc1U42s
         DcxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1rwbJM462mkcs2a4PZtcLRIS3iii9rEHHa3eCFevBXM=;
        fh=MjUOrncxcOS7ewzxdeH04yXRjVGd0k/+2BjnoLm+Zdw=;
        b=H1jq3EWd1JioumucPJj9eR3ImpUhQgbz/kxCgrtH+q4KClidhW+oDiXArz13nN7CT1
         A1pVN6tJZiqYGxqcYgIEAZ6DITC8Mpe0AzA1JsjzWhS07jQRI97kuWffuv91lgGtwdl4
         maLpjeHpja4dfyRTP2knOVmrIpkco/zxTLRjGnyESC1LSzYedR0dvuJOBzXz4/A3bLpR
         y/1E6D3YQzwvo2Bgixeq4gjsMxc3+2ZKxxdDMwR4um1HL9rUoI4CAdJjIcaVNG8n1Xlq
         AKniHSVFPxllgOUUSXnJ375S+YH7tnrLw5Is9xex2oCioCLqmp9r7evaoXFeFpOXMJnW
         lb+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777016461; x=1777621261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1rwbJM462mkcs2a4PZtcLRIS3iii9rEHHa3eCFevBXM=;
        b=d4vQcc1/uuAq0HuzOYiCC6ADh5RnLzKSe8EYVhn1CQ2Qq6rZGXQk2RrEqDmJyLR7Rg
         5DwQOnOK/OnpIQj21ar01SF1V8gQtmWzzW1TWNHBANCwjUuMfdbB6A9KdTUUXQAedL5c
         BodLu9Wll8nh68u6NqUfDNx62TmKR4kB2yXf0NAu2EgWznfuCWM8fdtg+SYaxM5hjSGi
         PbIAAUKEeZg+7EVl0oFPSsdSAvso8VGyHqaHjtVD4VGatea0srhtIDsUb9cQtyE40CEH
         jd5AMTa+ByHa+wSM2Wz0p8BFjPIvG39kAfiSlBYxhQfIfF8bYCxyKZ1FLubmkAKoXre1
         F4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777016461; x=1777621261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rwbJM462mkcs2a4PZtcLRIS3iii9rEHHa3eCFevBXM=;
        b=FG3j/vT11rDcdMgVznylaPVcAucTUAF+kNKBYVnF+Zt7yfV6YqIBkH6ZQZrcD0F+d+
         k6cY8L1QZGbJ0PtP06E/TIgGNYE4wHc5fylOMOaDYmLWVptu8sh4gzg3sZDnjBCjalJk
         SDoHZER/dpddiRe3TmaAUg/Ckvvni75YGy1uey91SOHICiH7hcAq4CWZxBAlAocQrGUj
         AvGf0HFRFWRdjuwsuPlMIjo5tVKR8cSAcyCdT80MPgg1SluF+jc1DZyzIWAcQ5cWmnRp
         Mn7xZR/dQVzRAdH3NH/tDBGVhq0FFmeH6xHcjEpZ6TTlXxqINVqMRwlxv4f1pCiqqg5s
         M10A==
X-Forwarded-Encrypted: i=1; AFNElJ/JJnyIypTChEJYixzmKd6WExAHiT0BbplqnmqrzlsiENgO0/BAc25LKd49ENZ1l9oVGqodUD2Kxlsp+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwN69RxA2UWwyQzwzBfbmIXTN0YUUykQ1EuMO0/N6UIaSltK7NE
	8mGnBqyK3zWKykaN5MLSvSHsJUojFIuldH5cv8cRyJVUHjg53tdQesqd6r9jN498VYhMY5RE1oC
	RTszLfb1uhCJKE2bw+f3eLRa+undgj0A=
X-Gm-Gg: AeBDietevPF3LI58LpPNPuGCbXm8pjgF1rHYORMP6pdCJhGPIOwyz30gjLLGW96tw4X
	VFy9npxF54RQ5n6BzrQC6PErQOEa2zVAykTuN6RWIb7qlsUr+bJFksozm4mEolvdQ4/yYEm+X1B
	SbplUXTmyZyp6Rdw4+cpID+IUxuED9IhJbwgOKRBbjStHH2hyAtCjPBogaQ2cjHvYBiHEzcLedX
	OBLC00Jz+NTuli0LyVNPlNoN0nOQZkxVvsizC7EM4D2OiSQY2Pru3y3HcuQlxncGgdr9sMPAhfV
	K9FiuWDogxMNZ5UZJ47y
X-Received: by 2002:a53:ac93:0:b0:651:bd7e:c04c with SMTP id
 956f58d0204a3-653119c494cmr20614638d50.21.1777016461293; Fri, 24 Apr 2026
 00:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415145708.3331818-1-lgs201920130244@gmail.com>
 <177645836617.906013.5675762942401997007.b4-ty@b4> <897f442d-4e04-4b70-b716-38fd10b8af36@kernel.org>
 <f661cf47-18bb-44f2-8764-c9f0b4fb68b1@kernel.dk> <CANUHTR8W7tz0me90GDci97ee6N+3MpB7uVYYFN0dtTf9u_Ui2g@mail.gmail.com>
 <2026042411-repressed-manliness-4ee9@gregkh>
In-Reply-To: <2026042411-repressed-manliness-4ee9@gregkh>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 15:40:46 +0800
X-Gm-Features: AQROBzD7oP01iGJO03f9pinRfdfCsBQH9AjYJ8PiauZIUw4gABPVYWeiSnqKu4A
Message-ID: <CANUHTR_JwTXpmE_Y6FbDfgqbJgBOjJyjR75ycW7WfLDuTbEdQw@mail.gmail.com>
Subject: Re: [PATCH v2] floppy: fix reference leak on platform_device_register()
 failure
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jiri Slaby <jirislaby@kernel.org>, 
	Denis Efremov <efremov@linux.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

Thanks for reviewing and pointing this out.

On Fri, 24 Apr 2026 at 12:15, Greg KH <gregkh@linuxfoundation.org> wrote:
>
>
> Can you go back and verify that all of the other patches you sent out
> for this same pattern are also either ignored, or reverted?
>
> thanks,
>
> greg k-h

Yes, I will go back and check all the other patches I sent for this same
pattern. For any cases involving static platform devices or similar static
objects where this fix is not appropriate, I will follow up by email to
make sure they are either ignored or reverted as needed.

Thanks again for the guidance.

Best regards,
Guangshuo Li
