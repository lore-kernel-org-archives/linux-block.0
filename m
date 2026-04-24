Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18902BB17;
	Fri, 24 Apr 2026 04:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777004138; cv=none; b=OIx3lAIq+ZhvfRkiOLY6ex45I4cgx1glL+K5hYr+QB4o6U8JikRHDofUplODCpN6v9sjg4h7YA+2W52NFBhsNtqPhebP3zfaMVKJTNSJIG5vnwyqb15vxyNkW5/+FcvVdFEUoip2QQLyiQkU3dsfSRsKcvMARheljKhMF3V51RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777004138; c=relaxed/simple;
	bh=qSbCLwo9bNjTXLml8YwjVUdVAAJT4kc7plZxPADYoHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmAUp6j4AT3oK+MDG25U+oSGrahdZd8TI+7afkfemmI0osNFXM3vLjXq4F56CJn40KAH3DpYjfuJ2nUtY5K5gVoCsSPy9k2tpY3xyUtAz8TC/bGB0hsk6CLXFu6i6MfTwNH12p6wZ9xxxGFwZ/Gk1YgZCNz3WT7yW+7hAd4vQhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JEfPEScm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JEfPEScm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1071C19425;
	Fri, 24 Apr 2026 04:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777004138;
	bh=qSbCLwo9bNjTXLml8YwjVUdVAAJT4kc7plZxPADYoHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JEfPEScmFIV2drI/h5U9JhpLn8mSRtCVMdHWaYPBctUnTIP4FQ20GiuJdFiGdDM0S
	 i39fZLijXcEl4d0yqeQ+1fw7Hl7VXKlV3ndk1OyriQ6wpGrl0XhONg5msXfe6rX29f
	 05S8OGq92Tp19Y4jsKAHsd5tp58aY0moCS+ylRJQ=
Date: Fri, 24 Apr 2026 06:15:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jiri Slaby <jirislaby@kernel.org>,
	Denis Efremov <efremov@linux.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] floppy: fix reference leak on
 platform_device_register() failure
Message-ID: <2026042411-repressed-manliness-4ee9@gregkh>
References: <20260415145708.3331818-1-lgs201920130244@gmail.com>
 <177645836617.906013.5675762942401997007.b4-ty@b4>
 <897f442d-4e04-4b70-b716-38fd10b8af36@kernel.org>
 <f661cf47-18bb-44f2-8764-c9f0b4fb68b1@kernel.dk>
 <CANUHTR8W7tz0me90GDci97ee6N+3MpB7uVYYFN0dtTf9u_Ui2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANUHTR8W7tz0me90GDci97ee6N+3MpB7uVYYFN0dtTf9u_Ui2g@mail.gmail.com>

On Fri, Apr 24, 2026 at 11:14:17AM +0800, Guangshuo Li wrote:
> Hi Jiri, Jens,
> 
> Thanks for the review and for catching this.
> 
> On Thu, 23 Apr 2026 at 19:06, Jens Axboe <axboe@kernel.dk> wrote:
> >
> > > The patch is likely wrong. Given the pdev is static, the struct device
> > > has no ->release, so releasing it will trigger a warning. AFAIR, the
> > > consensus was to fix platform_device_register() proper.
> >
> > Thanks for letting me know, I'll revert this change for now.
> >
> 
> You are right that this fix is not appropriate for this case. Since the
> platform device is static and the embedded struct device has no release
> callback, calling platform_device_put() / releasing it here is wrong and
> can trigger warnings.
> 
> Please disregard this patch. I will drop it and not pursue it further in
> its current form.

Can you go back and verify that all of the other patches you sent out
for this same pattern are also either ignored, or reverted?

thanks,

greg k-h
