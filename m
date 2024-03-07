Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC4321A14
	for <linux-block@vger.kernel.org>; Thu,  7 Mar 2024 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709835259; cv=none; b=jr6M692q/d1V8Ct1aDbIAISQF5/9KzaZvQEKMKGmo7+zWXzfXoadjCGxK0Lkt5yuEzFhbUxIVPEjbKKXJ+GFeQTYe4qNLx5kRR7SxtmX8iP+3x1bvtBtF4AxLA8QimE5/UD26h6zGqRF/prrME0nPE6ijnEpEvLjzV076Eoc9zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709835259; c=relaxed/simple;
	bh=ush2n6ZCUkwtqTDsLepiD2amdikGIA7J2+mciUIR1ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6AmxxLIrFh8fKm/86Ezee5ZaVS95ty7f5BteSFRG2pjZ7WndAhaAq8PJTD8MMYuJgPRkVXHoEjCZQ9JPvrdEYbGbi4bfEeEnT9aoTZK3Xg5neq2YCGAr61fR3e1qIvOHOWJqhwpjPV1+eNw1z+TtR9M5cyIraHO/QbbUbQuwAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tscyrlJc; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tscyrlJc"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-428405a0205so9051cf.1
        for <linux-block@vger.kernel.org>; Thu, 07 Mar 2024 10:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709835256; x=1710440056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ush2n6ZCUkwtqTDsLepiD2amdikGIA7J2+mciUIR1ug=;
        b=tscyrlJcklZLW4gysqP47SDIIHDRWD5W/W8R0xkovhAmNye3lhaDdt4vpoxpoSVvTo
         cnFbdFLxqjSno05YOzUCzXKaKvCjM8vp/eZO7xZVwlfoOV0V1eM/nycPIYllytzZwIXs
         6YCP+WUNPzAVdm9KpxRuXqWdAR3T/nbrV0NpofsGJ4h6eFYvT4R06McfqfbRgueeSErW
         70dBLifx1Umgu5NyxnkQ7eSdz4PZsVFu3VnXNY2lPb9OSwfAIsIXbFMf/d4pMsFeOQ6A
         487os0Bz+l2AdkSD5ivKK3SL8rGK5X8CuOD9Vf9RqLGelchIic/43ZQH+w9oD3pmgiLM
         2MTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709835256; x=1710440056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ush2n6ZCUkwtqTDsLepiD2amdikGIA7J2+mciUIR1ug=;
        b=SDDX+JF/ToJ6C+ckV3ucmOBEcr/iRW0Uk7NZWuVKj4Wy0U3VOxW3ymwLG8FlaQ1E/2
         yekwmvOXf+69GWe39s+24m/qt+C9+NfNtOXxoxFAOJcpP+zYGK57FsKaEUbwrnpakHfM
         U7Eq4+kIOeYh9qkYAR8XOdqAN4Os8qshckQtrssqKLAXzn6VVmmriVKeU7goCAh+qPyk
         pJYZtKbpvCQ/iDnnHnewrmtcIfzbpjggYvBwuOY5AV1QXKRtd8UKBqdNZzvWEItiwBcI
         pjLKhJMMiDFTZx5ZLjSZZoM0mg8rio16Jq614JOWmPoAymXGYjs2wvtICzPJ+9PWIfuK
         oNnw==
X-Forwarded-Encrypted: i=1; AJvYcCVDZMnw6zExj99rEvhmJeLeunFgfc7VS2Uc2R0n4UMZu1+sIrCxfBP1lBchmOssdB+Yq/dW9PcSmr8IOfLqnnIdndv1SdPdbDmtnqQ=
X-Gm-Message-State: AOJu0YwQoz+aThsGdRwpu8yD6WgldQV95u5p7kx49HSw3/8TUuBafOq9
	pEGcWmTPKrwlmlTDBIi40mzR0dYazZwYkyU/2X2xXjU/KMh20qVEl0OxjZ2J4ER8xldFJ4q01DV
	e3Fyaj37uCuOeZkTes4wwmgLdOsxw+JHvVYRO
X-Google-Smtp-Source: AGHT+IHu0uPTL6/EGy0p7K3ug6czmdQyEoVz4ZC9Cz3oZZerlUx7PWc/16KGTccZuo6OQq4gNW4IkXm4N5wyJTNUcQE=
X-Received: by 2002:a05:622a:13cf:b0:42f:a3c:2d54 with SMTP id
 p15-20020a05622a13cf00b0042f0a3c2d54mr333212qtk.21.1709835256039; Thu, 07 Mar
 2024 10:14:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP9s-SrvNZROseNkpSL-p-qsO0RT6H+81xX4gg-TV71gQ_UbYA@mail.gmail.com>
 <20240212154411.GA28927@lst.de> <CAP9s-Sr3_GVYBv-XObPRC9L27jJoQqX40d8g3gysEmy6VdQS1Q@mail.gmail.com>
 <CAP9s-So3NkfexGOQ2ogt5duaCevbWXb3wJf_zyB2F+eotBmg6w@mail.gmail.com>
 <CAP9s-Sp+H8rBUyAURpKOu9ZuiU_GRTmqc+ksoiJx_xHdfFHqig@mail.gmail.com> <27bff287-049d-5bbb-2392-fd5f099bed3c@huaweicloud.com>
In-Reply-To: <27bff287-049d-5bbb-2392-fd5f099bed3c@huaweicloud.com>
From: Saranya Muruganandam <saranyamohan@google.com>
Date: Thu, 7 Mar 2024 10:14:05 -0800
Message-ID: <CAP9s-SrXvm5MfhXCMBYfsEv9xKWqvkkLp2ZjndYrJ65m5x8M_w@mail.gmail.com>
Subject: Re: regression on BLKRRPART ioctl for EIO
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	sashal@kernel.org, Ming Lei <ming.lei@redhat.com>, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I think we can fix this by returning error from bdev_get_whole() if
> bdev_disk_changed() failed, this will cause that open disk to fail now,
> however, I think this can be acceptable.

Thanks for the response!
I agree this would fix the regression for the ioctl.
However, since returning an error from blkdev_get_whole is new
behavior, I wasn't sure what all parts it affects.

So this is just a ping to let you know that I am also waiting to hear
from Christoph.


On Mon, Feb 26, 2024 at 7:13=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/02/27 10:38, Saranya Muruganandam =E5=86=99=E9=81=93:
> > Hi,
> > Is there advice on how to fix this `blockdev --rereadpt` regression in
> > the kernel?
> > Would appreciate some advice.
> >
> > Thanks,
> > Saranya
> >
> >
> > On Mon, Feb 12, 2024 at 8:01=E2=80=AFPM Saranya Muruganandam
> > <saranyamohan@google.com> wrote:
> >>
> >> When we fail to read from the disk, BLKRRPART used to be able to
> >> capture and bubble this up to the caller.
> >> It no longer does since we no longer capture the error from bdev_disk_=
changed.
> >>
> >> Here is an example with fault-injection:
> >>
> >> # echo 0 > /sys/kernel/debug/fail_make_request/interval
> >> # echo 100 > /sys/kernel/debug/fail_make_request/probability
> >> # echo -1 > /sys/kernel/debug/fail_make_request/times
> >> # echo 1 > /sys/block/sdc/make-it-fail
> >> # blockdev --rereadpt /dev/sdc # no error
> >> # echo $?
> >> 0 # incorrectly reports success.
>
> I take a look at this, and it's right the root cause is commit
> 4601b4b130de ("block: reopen the device in blkdev_reread_part") ignore
> errors from bdev_disk_changed() now.
>
> I think we can fix this by returning error from bdev_get_whole() if
> bdev_disk_changed() failed, this will cause that open disk to fail now,
> however, I think this can be acceptable.
>
> Christoph, do you think so? Or we should distinguish ioctl and open
> device and only let ioctl to fail.
>
> Thanks,
> Kuai
>
>
> >>
> >> Whereas fdisk and sfdisk correctly report the issue :
> >>
> >> # sfdisk /dev/sdc
> >> sfdisk: cannot open /dev/sdc: Input/output error
> >> # fdisk /dev/sdc
> >>
> >> Welcome to fdisk (util-linux 2.28.2).
> >> Changes will remain in memory only, until you decide to write them.
> >> Be careful before using the write command.
> >>
> >> fdisk: cannot open /dev/sdc: Input/output error
> >>
> >> Best,
> >> Saranya
> >>
> >>
> >>
> >> On Mon, Feb 12, 2024 at 8:00=E2=80=AFPM Saranya Muruganandam
> >> <saranyamohan@google.com> wrote:
> >>>
> >>> When we fail to read from the disk, BLKRRPART used to be able to capt=
ure and bubble this up to the caller.
> >>> It no longer does since we no longer capture the error from bdev_disk=
_changed.
> >>>
> >>> Here is an example with fault-injection:
> >>>
> >>> # echo 0 > /sys/kernel/debug/fail_make_request/interval
> >>> # echo 100 > /sys/kernel/debug/fail_make_request/probability
> >>> # echo -1 > /sys/kernel/debug/fail_make_request/times
> >>> # echo 1 > /sys/block/sdc/make-it-fail
> >>> # blockdev --rereadpt /dev/sdc # no error
> >>> # echo $?
> >>> 0 # incorrectly reports success.
> >>>
> >>> Whereas fdisk and sfdisk correctly report the issue :
> >>>
> >>> # sfdisk /dev/sdc
> >>> sfdisk: cannot open /dev/sdc: Input/output error
> >>> # fdisk /dev/sdc
> >>>
> >>> Welcome to fdisk (util-linux 2.28.2).
> >>> Changes will remain in memory only, until you decide to write them.
> >>> Be careful before using the write command.
> >>>
> >>> fdisk: cannot open /dev/sdc: Input/output error
> >>>
> >>> Best,
> >>> Saranya
> >>>
> >>> On Mon, Feb 12, 2024 at 7:44=E2=80=AFAM Christoph Hellwig <hch@lst.de=
> wrote:
> >>>>
> >>>> What scenario are you looking at?
> >
> > .
> >
>
>
