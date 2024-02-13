Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C08883B
	for <linux-block@vger.kernel.org>; Tue, 13 Feb 2024 04:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707796897; cv=none; b=NNDM4zRCbz1yUbtHWQzOdUXGbtFzMgTNffQijHKbOpBEDPVbD84itMDmkP/KWNVjRsZ90oSHoLx9D9UIXBGL734oaHF3VpecxvhLsTpbLy1KyQsCd4H4MyRjZYoV+HKhZq0P8xuh/EMwwiLn6b+8xznc+uk3yo02o42jmADkk9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707796897; c=relaxed/simple;
	bh=0bGjvut+Gcz3tVFdykEDhNKhV4whEN2LeLAgifJFlT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSt/ayJbOmouxonL5SeDrrK48/ZqlZX0XKX0b5WtJeirbiG0KP/nhKJWVmACejld1MKiynZkhutpeL9vi67mie4qGT8L/wR5PfnhikygNsVjxW8ATO8ODqwj6dlsqDYPQqGBfI/+iCIIeWqghvWf838AptUpT12LJOgtr4g6uAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mJudvbcS; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJudvbcS"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42dac9f7183so102781cf.0
        for <linux-block@vger.kernel.org>; Mon, 12 Feb 2024 20:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707796894; x=1708401694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bGjvut+Gcz3tVFdykEDhNKhV4whEN2LeLAgifJFlT8=;
        b=mJudvbcSsngrJC8PMstM+iaRAsW1/BooVou22MUoLcAPFg3xbHRR4a+sBASfE0/RCB
         9U1p5HxxwRWvtgr6MnvuawdS48rIlUBrEomRuts7zqa7lIERLRqjEU3T4Ll5GBB3Iy7k
         If4szqEdmTti5+Y+OGz/tMhTArwadudOEVot5ULgsSi5l9IWRoJBVbrgWo9tyzUMYUTe
         SpSZ0GBjJ0pMA5PZA48h5XMkT/nRqyLaVIQlEpTKlD0A82yA6o5e7jV+1B9d/zz7fknD
         EWWLjn3gHgtdpBOKF1YSQktGMMH/jNXubq+2jzWjfh+SwFAYx5pTe15eNjiQkzoaq+Dk
         c3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707796894; x=1708401694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bGjvut+Gcz3tVFdykEDhNKhV4whEN2LeLAgifJFlT8=;
        b=Wyo5xEXVhPo7nCUEmaSLHz4c/zOcT0wcFt+LLOpCjVTYKcRGPmnCte90ya+Fnh7mWb
         P09g3k5i+zVM8KMyhgdK0A87lDLlVfUjfpAFM+CN+iH/SIsZ+/h6BPrfgigr6gUXjHBV
         siGdXvRXVuKegp/c8YQBa194BaCCmUYBY+Yz50iBGGI2xHpn77Lu0wJ0OPpOHDZ5KR6N
         +h2r571OeCwVt/EYoC6qbrPx8B51RS0/bYMZR7YRFGuv2qy4k7pJsqz8yn18rM3bXArc
         EqJJef/AdHbgxBxmqHx4/mrnIgA3Bf4GRDAhVIE6XxCdqJTosLWKtQhPLpOY69KU8b6a
         Spcg==
X-Gm-Message-State: AOJu0YyAMIrRAzSSyA3X2FelIazlm+PpSVaTuQbOu/TjYgfYNpJzym50
	EwCLsWrM69vtECStmnETWXHtnzD77xVG3m9gY3E3knRtCOttqVfFcF5N+fowxcxsT/HroPHuAj3
	jsgI675Wuvu0uoWPt3lbxa8MBwLPFhyP+XjD0
X-Google-Smtp-Source: AGHT+IH4VLtiqCqTTbkbjm8BJKQ9g4O/LFAbFTm09xsUdtw8kP/1NqJMLhhGP8j8Mz6Ruc5wMXcK5RAop0RK6WAtOPs=
X-Received: by 2002:a05:622a:8009:b0:42c:7346:dd1d with SMTP id
 jr9-20020a05622a800900b0042c7346dd1dmr103125qtb.28.1707796894300; Mon, 12 Feb
 2024 20:01:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP9s-SrvNZROseNkpSL-p-qsO0RT6H+81xX4gg-TV71gQ_UbYA@mail.gmail.com>
 <20240212154411.GA28927@lst.de> <CAP9s-Sr3_GVYBv-XObPRC9L27jJoQqX40d8g3gysEmy6VdQS1Q@mail.gmail.com>
In-Reply-To: <CAP9s-Sr3_GVYBv-XObPRC9L27jJoQqX40d8g3gysEmy6VdQS1Q@mail.gmail.com>
From: Saranya Muruganandam <saranyamohan@google.com>
Date: Mon, 12 Feb 2024 20:01:23 -0800
Message-ID: <CAP9s-So3NkfexGOQ2ogt5duaCevbWXb3wJf_zyB2F+eotBmg6w@mail.gmail.com>
Subject: Re: regression on BLKRRPART ioctl for EIO
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, sashal@kernel.org, 
	Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When we fail to read from the disk, BLKRRPART used to be able to
capture and bubble this up to the caller.
It no longer does since we no longer capture the error from bdev_disk_chang=
ed.

Here is an example with fault-injection:

# echo 0 > /sys/kernel/debug/fail_make_request/interval
# echo 100 > /sys/kernel/debug/fail_make_request/probability
# echo -1 > /sys/kernel/debug/fail_make_request/times
# echo 1 > /sys/block/sdc/make-it-fail
# blockdev --rereadpt /dev/sdc # no error
# echo $?
0 # incorrectly reports success.

Whereas fdisk and sfdisk correctly report the issue :

# sfdisk /dev/sdc
sfdisk: cannot open /dev/sdc: Input/output error
# fdisk /dev/sdc

Welcome to fdisk (util-linux 2.28.2).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

fdisk: cannot open /dev/sdc: Input/output error

Best,
Saranya



On Mon, Feb 12, 2024 at 8:00=E2=80=AFPM Saranya Muruganandam
<saranyamohan@google.com> wrote:
>
> When we fail to read from the disk, BLKRRPART used to be able to capture =
and bubble this up to the caller.
> It no longer does since we no longer capture the error from bdev_disk_cha=
nged.
>
> Here is an example with fault-injection:
>
> # echo 0 > /sys/kernel/debug/fail_make_request/interval
> # echo 100 > /sys/kernel/debug/fail_make_request/probability
> # echo -1 > /sys/kernel/debug/fail_make_request/times
> # echo 1 > /sys/block/sdc/make-it-fail
> # blockdev --rereadpt /dev/sdc # no error
> # echo $?
> 0 # incorrectly reports success.
>
> Whereas fdisk and sfdisk correctly report the issue :
>
> # sfdisk /dev/sdc
> sfdisk: cannot open /dev/sdc: Input/output error
> # fdisk /dev/sdc
>
> Welcome to fdisk (util-linux 2.28.2).
> Changes will remain in memory only, until you decide to write them.
> Be careful before using the write command.
>
> fdisk: cannot open /dev/sdc: Input/output error
>
> Best,
> Saranya
>
> On Mon, Feb 12, 2024 at 7:44=E2=80=AFAM Christoph Hellwig <hch@lst.de> wr=
ote:
>>
>> What scenario are you looking at?
