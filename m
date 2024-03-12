Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4611F95F
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710248298; cv=none; b=TSDOHKM3gM/x8ppzegym1dmkwwIezaee8+ekchQgMSflGeis+pHgUnkUQeK+TE34oE/ZJbsRKG3nzRN+lzhjNUF4N00Qx2k7vp1bEFBEbx5Bt5KCJmzNeF8VDzQ8lXRqmJO/ZppdQGRiMjrKKo7guBNfvT9tJY6MzALtZ8qNdm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710248298; c=relaxed/simple;
	bh=8jJKj6cc4Y6n79Wnr/+MYO0ufoa4sZZLw3fvdmmgQU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNzFS0ZxtcdHQY4WFajcodUwfrACdnSA5n5fRgBjKFNq5+rSWYYl0CAxoj8niZCZyTCZgNUSXGzEkGt/14z/i1Qhtf9ft5JQvvbNiB9UAmf2XfxsySMYXnTu3i1IfMaMt6ThGbHImjMURFBGJ+3ktRrs+Bu79tptftS6w3vCo5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ko4JHe0a; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ko4JHe0a"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso5342908276.0
        for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 05:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710248295; x=1710853095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8jJKj6cc4Y6n79Wnr/+MYO0ufoa4sZZLw3fvdmmgQU4=;
        b=Ko4JHe0abXk6vELJfOVNeCXW6Psd4MEs2WmNKhQWTYA+ZJn9AxC4t2YoVm1R5RT+65
         cumAGBxnYu+au92OCNBMcWXtyU1awhPYtmsPbokxKrq+Tu086qJWxybQTsPyVAr/9s7X
         TRozxxNoUOfuvkiBHppMdAe2SeN/a/p8S16wvW7ne3z0nATjQgKbfA5Ga5nF5KMopi9N
         BOaE81rZyKYpKOM27Z00HA7T1NBOBgeFsDo99lKr5CWnzcTfAH+dfEZ3N/X0Kw+wuAo8
         JMtXyxt7slKudV4lr7ClG8W1ja3dAVr/yuw41Nau9uMrDCrXM1gt/RJrG1HZUYPeUBQ1
         gcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710248295; x=1710853095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jJKj6cc4Y6n79Wnr/+MYO0ufoa4sZZLw3fvdmmgQU4=;
        b=oZxLu72jp5uhXm3CNPDDkx5qGfVakCsAX+zncv7bzJHrslz1y329mwkdhs/QZYikst
         +pUpRHbv1XE2+WIkKJkrnt2w2kzmSIeWrqfteQ74DyjyM6bgUq+n25ghju0Lu8AGVdU5
         J7DvKO+yR/M1g/t6hhdMACBAT5h21dts1m1ZemhpW4Yh8rm70AtGg7HISdZRdfdbsXwt
         0gSl6jwTOJRgT58Ikn8fMMhBZd3ZdXy9y1L/b58uGvqIVzXtQ6axGOY+7XL6UbrmIp33
         11KVbYua/utnFgAUfmsTJzWbic5HzUNLELq5IsdzOK4ocoaeaiPdiw6jxsiGFBCeIQp+
         oDuw==
X-Forwarded-Encrypted: i=1; AJvYcCVZu5ZeJDH+BLNPUH0uDgxq9dkL51wUGd1QPnMkX9DYV4CteiTTK/2kVaNjT5bQQ5U6bOgqGuaCGA+WSuhYXK/p+uvnn4eBiYQtD8c=
X-Gm-Message-State: AOJu0YysyPOgici2sEJeNwWkzcaCxbpuCzhIR3QblBJLApLH389QIIy4
	jtVJZ5N+fl9u1THlwu5jSgDQtEa2940Be4OyS+75rhNCnTREiEavGlC+iqdSJOgDEoawJBRvJAo
	i4FairiduLR4nGYDLwWtA80GzKeRDp1KurgWi5A==
X-Google-Smtp-Source: AGHT+IEXjBJ8SkftenAiispF7JkfvuYojibcHcU8qjJpODRNR2jabK5webcKiPm5H6fkVHd0TPiRsUtBdXjK4ZzWbuo=
X-Received: by 2002:a25:aa91:0:b0:dcb:aa26:50f9 with SMTP id
 t17-20020a25aa91000000b00dcbaa2650f9mr7296508ybi.46.1710248295348; Tue, 12
 Mar 2024 05:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709667858.git.daniel@makrotopia.org> <CAPDyKFpQfue5Fi0fFSnqHNg2ytCxAYfORVP_Y86ucz2k5HRuDA@mail.gmail.com>
 <ZfBK5qT_GO_FgtQP@makrotopia.org>
In-Reply-To: <ZfBK5qT_GO_FgtQP@makrotopia.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Mar 2024 13:57:39 +0100
Message-ID: <CAPDyKFr7mMEZE5n=6kxxsj9P3oLjLyVx20O9q0-pmyXzXYk52A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/8] nvmem: add block device NVMEM provider
To: Daniel Golle <daniel@makrotopia.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Christian Brauner <brauner@kernel.org>, Li Lingfeng <lilingfeng3@huawei.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Min Li <min15.li@samsung.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Hannes Reinecke <hare@suse.de>, 
	Christian Loehle <CLoehle@hyperstone.com>, Avri Altman <avri.altman@wdc.com>, 
	Bean Huo <beanhuo@micron.com>, Yeqi Fu <asuk4.q@gmail.com>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	"Ricardo B. Marliere" <ricardo@marliere.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org, 
	Diping Zhang <diping.zhang@gl-inet.com>, Jianhui Zhao <zhaojh329@gmail.com>, 
	Jieying Zeng <jieying.zeng@gl-inet.com>, Chad Monroe <chad.monroe@adtran.com>, 
	Adam Fox <adam.fox@adtran.com>, John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Mar 2024 at 13:30, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Hi Ulf,
>
> On Tue, Mar 12, 2024 at 01:22:49PM +0100, Ulf Hansson wrote:
> > On Tue, 5 Mar 2024 at 21:23, Daniel Golle <daniel@makrotopia.org> wrote:
> > >
> > > On embedded devices using an eMMC it is common that one or more (hw/sw)
> > > partitions on the eMMC are used to store MAC addresses and Wi-Fi
> > > calibration EEPROM data.
> > >
> > > Implement an NVMEM provider backed by block devices as typically the
> > > NVMEM framework is used to have kernel drivers read and use binary data
> > > from EEPROMs, efuses, flash memory (MTD), ...
> > >
> > > In order to be able to reference hardware partitions on an eMMC, add code
> > > to bind each hardware partition to a specific firmware subnode.
> > >
> > > This series is meant to open the discussion on how exactly the device
> > > tree schema for block devices and partitions may look like, and even
> > > if using the block layer to back the NVMEM device is at all the way to
> > > go -- to me it seemed to be a good solution because it will be reuable
> > > e.g. for (normal, software GPT or MBR) partitions of an NVMe SSD.
> > >
> > > This series has previously been submitted on July 19th 2023[1] and most of
> > > the basic idea did not change since.
> > >
> > > However, the recent introduction of bdev_file_open_by_dev() allow to
> > > get rid of most use of block layer internals which supposedly was the
> > > main objection raised by Christoph Hellwig back then.
> > >
> > > Most of the other comments received for in the first RFC have also
> > > been addressed, however, what remains is the use of class_interface
> > > (lacking an alternative way to get notifications about addition or
> > > removal of block devices from the system). As this has been criticized
> > > in the past I'm specifically interested in suggestions on how to solve
> > > this in another way -- ideally without having to implement a whole new
> > > way for in-kernel notifications of appearing or disappearing block
> > > devices...
> > >
> > > And, in a way just like in case of MTD and UBI, I believe acting as an
> > > NVMEM provider *is* a functionality which belongs to the block layer
> > > itself and, other than e.g. filesystems, is inconvenient to implement
> > > elsewhere.
> >
> > I don't object to the above, however to keep things scalable at the
> > block device driver level, such as the MMC subsystem, I think we
> > should avoid having *any* knowledge about the binary format at these
> > kinds of lower levels.
> >
> > Even if most of the NVMEM format is managed elsewhere, the support for
> > NVMEM partitions seems to be dealt with from the MMC subsystem too.
>
> In an earlier iteration of this RFC it was requested to make NVMEM
> support opt-in (instead of opt-out for mtdblock and ubiblock, which
> already got their own NVMEM provider implementation).
> Hence at least a change to opt-in for NVMEM support is required in the
> MMC subsystem, together with making sure that MMC devices have their
> fwnode assigned.

So, the NVMEM support needs to be turned on (opt-in) for each and
every block device driver?

It's not a big deal for me - and I would be happy to apply such a
change. On the other hand, it is just some binary data that is stored
on the flash, why should MMC have to opt-in or opt-out at all? It
should be the upper layers who decide what to store on the flash, not
the MMC subsystem, if you get my point.

>
> > Why can't NVMEM partitions be managed the usual way via the MBR/GPT?
>
> Absolutely, maybe my wording was not clear, but that's exactly what
> I'm suggesting here. There are no added parsers nor any knowledge
> about binary formats in this patchset.

Right, but there are new DT bindings added in the $subject series that
allows us to describe NVMEM partitions for an eMMC. Why isn't that
parsed from the MBR/GPT, etc, rather than encoded in DT?

>
> Or did I misunderstand your comment?

Maybe. I am just trying to understand this, so apologize if you find
my questions silly. :-)

Kind regards
Uffe
