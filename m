Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226371860
	for <linux-block@vger.kernel.org>; Wed, 20 Mar 2024 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710894029; cv=none; b=PwLpQeUM4kDcHhwrTYtq8NHVyWY6cYfL8QT3QePJ/sMqmogz9Ua1OgAavUldx1oCic4K1K0N3FznA/bsDfs/3GVtKQvIZo0zyLXCiOuuiwqtrBc1z9gsldd9DQNmdeMFiXQG75aJdmAFCH0FRwu39MBhRK2uNTrBrLfYNjN62kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710894029; c=relaxed/simple;
	bh=S2pXbpkdtw5niksIXUAUq+QWlkz7InkVAfpKUicfRGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYj2xs8fuTz8lzUdzUHbnT3D2WOICeN8sgIjkbydo3G9yAWftuLKijBj5EEXezOoBU5gsCO/11XX68PpHURM1KpOtd8ETDlZrRdCFtgdKiGodcSQyOLA8xQyeYTEkHMccT0kkQ1Xsr71dVgo5ACqEmbbXp5TnFoUVrb2T3rNZpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YohgyGxh; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YohgyGxh"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42ee0c326e8so115781cf.0
        for <linux-block@vger.kernel.org>; Tue, 19 Mar 2024 17:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710894027; x=1711498827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AHy62HFc4Pyl7yVDLuxUSi59vdJxQdwaeVbPnLAABw=;
        b=YohgyGxhc2AGufjd062BBtLCfP2ab4u33mtT706nH5o/VBgPBCltrEugB2gX4sYZwQ
         jQf4jCGO8oVmnnY9ERvt1dRjMPkgwUtfEOu1bgfgenDqQ0qizUgDFNCjQBkWUXdQaOTM
         9IZQcc707GOh75Vlc3aAHZXAyM+1Sgd/BT4bdiRBB6UhwGOIqmkolaqKQitH50B6L+Hq
         BsaIZsN6MxTM73Bdg+9aM+eU1Ax6t3wNNiM28uUhLU4+DWE7FqsyHBEaMbDJPZlE2nu/
         NzTKztwbm56HLxjTbZVHER6KoknfBIFtEj9NjWHjFjCh/NT/Su7w73HKjBEJ1oLoSou/
         HKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710894027; x=1711498827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AHy62HFc4Pyl7yVDLuxUSi59vdJxQdwaeVbPnLAABw=;
        b=KEzz02o1ZUmRgchnV8A4tauetIs4AVDo/SXvXYVX0JXVOqylAjZyxmgopjyqVouVQU
         k4KQ0MMBz93p1HtUwKuWIJKbTiV507Yg94ZR65FqjWEGs8uji35hFf/brgijK5OoqN5B
         El+8BWHTaE24KNGmm3xjLQpAetRhVTjmOzS5cFj39B04L8p82qzviO9tPvE4toualrzD
         0UxZI0gObxrDFnnQgRsHqsqEEVPN2GDT5bAegK+WOMrehEucp/JHDkyZXDlKCNlQhN/v
         E/Rr+thPq3YW+ywCQGD+dchxfjS5RoQneA/8p5dXPYCdJ9HFbO/+xhuIZ6phHfen7aj1
         mRKA==
X-Forwarded-Encrypted: i=1; AJvYcCV3gXbQwd4Ev9FYVBWP+rdCfCcgLw+Vi1/faVfo6pBqB7gGb3H/sdtFrJagKUl/3tnzWhm/NjWyx3azxJUyMWvHmzwq+Z1Sti1ydWk=
X-Gm-Message-State: AOJu0YySN+jn05sCO3mL2nZU9YpiL7+jIAVbBRn7Lh2F47rq+CE6ESJc
	4jzvXhLjPZ1ifnXUZ418TbPTc0YGUWII6tErks0KvhbLAnwrGFHAm5iHVfY/XqYA6ap5PEUGw8x
	uYpDE/e+GJqp/DHl8flV04MMpRdmVIJUdO7E/
X-Google-Smtp-Source: AGHT+IE+Koo9nX0b4IoFUF+Bex3GrCVUN0VESmGbY7Nqg2mPJo/DcxdsP5l1cJFNMbjEkrMi7MwCTmxBaIB5Q/FwBCw=
X-Received: by 2002:ac8:59cf:0:b0:430:a286:8cc1 with SMTP id
 f15-20020ac859cf000000b00430a2868cc1mr69424qtf.21.1710894026828; Tue, 19 Mar
 2024 17:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP9s-SrvNZROseNkpSL-p-qsO0RT6H+81xX4gg-TV71gQ_UbYA@mail.gmail.com>
 <20240212154411.GA28927@lst.de> <CAP9s-Sr3_GVYBv-XObPRC9L27jJoQqX40d8g3gysEmy6VdQS1Q@mail.gmail.com>
 <CAP9s-So3NkfexGOQ2ogt5duaCevbWXb3wJf_zyB2F+eotBmg6w@mail.gmail.com>
 <CAP9s-Sp+H8rBUyAURpKOu9ZuiU_GRTmqc+ksoiJx_xHdfFHqig@mail.gmail.com>
 <27bff287-049d-5bbb-2392-fd5f099bed3c@huaweicloud.com> <CAP9s-SrXvm5MfhXCMBYfsEv9xKWqvkkLp2ZjndYrJ65m5x8M_w@mail.gmail.com>
 <20240308163237.GA17159@lst.de>
In-Reply-To: <20240308163237.GA17159@lst.de>
From: Saranya Muruganandam <saranyamohan@google.com>
Date: Tue, 19 Mar 2024 17:20:14 -0700
Message-ID: <CAP9s-Sq7YHbcbUBMV==d+cz0yK-zB9zKzFJhVMkPWJKfV1gLpA@mail.gmail.com>
Subject: Re: regression on BLKRRPART ioctl for EIO
To: Christoph Hellwig <hch@lst.de>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, sashal@kernel.org, Ming Lei <ming.lei@redhat.com>, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Any advice yet?

I really appreciate the help.

thanks,
Saranya

On Fri, Mar 8, 2024 at 8:32=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Thu, Mar 07, 2024 at 10:14:05AM -0800, Saranya Muruganandam wrote:
> > > I think we can fix this by returning error from bdev_get_whole() if
> > > bdev_disk_changed() failed, this will cause that open disk to fail no=
w,
> > > however, I think this can be acceptable.
> >
> > Thanks for the response!
> > I agree this would fix the regression for the ioctl.
> > However, since returning an error from blkdev_get_whole is new
> > behavior, I wasn't sure what all parts it affects.
> >
> > So this is just a ping to let you know that I am also waiting to hear
> > from Christoph.
>
> I'd hate returning a failure and changing the interface, but I haven't
> come up with anything better yet.  Let me thing about this a bit more.
