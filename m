Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5DB26B755
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765558248; cv=none; b=eZU35/I7oydrb8OWNXNTcFru1Q3FtkUafIuaeCBOWtH9VFH9FY/JlLXASmToG00XqnLA9zZ9htHN+yQZO/1cPY7rMElPaDPqlLetjzaM+NFXFEipKjVRraeIk8Tt9g55meQlYlfAP+hfNMNcmC5ARKnAQS7/xC5aDrhyZBNukvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765558248; c=relaxed/simple;
	bh=gHqFmJu8Q7cEzcmAy0y+0r5LxtGfMwXgn88CsLSJY80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrwS63FxdOAvWa20q82YTVfDJPXDPA/GuLmIyCjKE575GVbqrzGaPjYG7W6RBOiSoRJnqoxiW/pD9uoQXCPzy4vPf0OFl50P6WGUA2DtyLUW0xr+3LpzIp2s805dOUSoAvNIECtIPy98J6DQR4X6s2lZhP2w0qPw1v4CObqHPvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Kerfs//+; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Kerfs//+"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7c32c6eb79dso70765b3a.1
        for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 08:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765558245; x=1766163045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6TtTuhlyGm4Yzy8Bwa+JBhXmcS0UPhYZfP/K0YNXHE=;
        b=Kerfs//+O9YJkJqjUC3VyP8BCGn6vb/FCkHiekSswPd3ywfiJUqLp5hIu8r3rJkJzg
         VL4Bx7fQuujYAfSex28aDUmiVAAomgutWVx+YaRhSeLvWNyHtWI4pAjaetpIfcq4YDLD
         MvkJqMTdGcmxDz5z8hThDbPihLk2aAGOr38IfeKikpGYykNsTiaPpD6ZXe4SLTPitOXQ
         B2NUVbzs+exEHTnTX45W7uQN6wRl7ucpw0JcKeDngKv3LIY3JL4U8r5NC+1uH6vE8r1r
         F6uNEVZxVjX51VM0RteTO2iSiaoS8YU64dj4u3LwtR/ufWfB2pE9YFm8PVsxSKw6Co/b
         z+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765558245; x=1766163045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P6TtTuhlyGm4Yzy8Bwa+JBhXmcS0UPhYZfP/K0YNXHE=;
        b=vfgGkWWp6WPOr7aR0GqzEWG4t46bIqFLyz1G3K1TNvPDOcwReFMZb/Ty/rCGuJ6Uot
         ATQeaS1XxIvqWsCk000PRqUMu4mJww0uCHlTRUczIOaW3ywqDEB+QrG4C0guYkziQI1s
         pOoFQbp2oTJI7SkdWJk9t83ZYVGhHyP7z8WnfTVFU7T2LXXzwDg1Bb/fSum/22oVp8zj
         gie8OZ/nnJr4CEEwQjVV79rN9PHahAnmWLOKTa23yUCOFUhdy+uuvoDBTI5NYO5t7jGd
         CUoK3GX3LCm3SvYnSMSxW6/sbpm0mQj+BZI2Pv4oEM16w29TFr1QhQfmQdKEyDyqWnJw
         32zw==
X-Forwarded-Encrypted: i=1; AJvYcCXOmLVn7pfbE8oRLI/5QH8kcAr+HoI065huFTe6t+dtQ04ga9pMx9JgYtJ9rQ57RvJLq2bEoj5/VU3ymw==@vger.kernel.org
X-Gm-Message-State: AOJu0YybXCCBcR42XTb7UIkOsU0oFvl8PZRkwVOx+cndj3mJqGYFGItl
	OVdZpvw/KXQyLaQfeZh1gGbHvMA+dK/0z4DdJYSXnowkW5VMDhdt0VPPgDh4wAlgjUcHLI/Az2Q
	bCK5X8ha+xGEVmJP0gJz/6BYCgolE/m5eIR/0+RxUbdizezzBLt8I
X-Gm-Gg: AY/fxX7BYh6wMYfKD9N8A3cj7vTbW0ZdqrCghxXqtAYK6aCNjmHAjmqBLhCd+4C5b0O
	dBjhmgmLke/ep8MBRA9EKa8f0O6Kz4+K49/23bpkJww/YE/9ExAYO6+SyV9K17FEK7fTlEe6UyB
	hPOFV6jZumE4VKXX1ApwZEWojlMLmaQ2hqdiEbN2b9ATAZIHGFjcZ+h6IQnug+l4Pn1qNCkU4CE
	sgbbO0+57VtVsW4H5CsNVQgyDZvrjzvM0SRMqV+YwaZbvfd9hUpK6YFG8BaXPZlrrhP8Oay
X-Google-Smtp-Source: AGHT+IEcJsxz5ZEELPu6pxm4vJWkI5dllQ3f0rhBgVRfUNTGD/NqYNvbUp05BHQg6uvLwAj4rrBSA4R+LEUpwwKjShM=
X-Received: by 2002:a05:7022:989:b0:119:e56b:c3f3 with SMTP id
 a92af1059eb24-11f34c47c98mr1052360c88.3.1765558244555; Fri, 12 Dec 2025
 08:50:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212051658.1618543-1-csander@purestorage.com>
 <20251212051658.1618543-5-csander@purestorage.com> <aTv06QEJIYyJKCVQ@fedora>
In-Reply-To: <aTv06QEJIYyJKCVQ@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 12 Dec 2025 08:50:32 -0800
X-Gm-Features: AQt7F2oV7VYFcC0-QUXJvhB3eLP1TVAemCkfOOOvLxD3ZsJNAOgqc72w4YyEZl8
Message-ID: <CADUfDZq7wno5FEKrJEQ-YNc_VzshNAoefjsrRL4AC6QK4c_DoA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] selftests: ublk: use auto_zc for PER_IO_DAEMON
 tests in stress_04
To: Ming Lei <ming.lei@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 2:56=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Thu, Dec 11, 2025 at 10:16:54PM -0700, Caleb Sander Mateos wrote:
> > stress_04 is described as "run IO and kill ublk server(zero copy)" but
> > the --per_io_tasks tests cases don't use zero copy. Plus, one of the
> > test cases is duplicated. Add --auto_zc to these test cases and
> > --auto_zc_fallback to one of the duplicated ones. This matches the test
> > cases in stress_03.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  tools/testing/selftests/ublk/test_stress_04.sh | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/tes=
ting/selftests/ublk/test_stress_04.sh
> > index 3f901db4d09d..965befcee830 100755
> > --- a/tools/testing/selftests/ublk/test_stress_04.sh
> > +++ b/tools/testing/selftests/ublk/test_stress_04.sh
> > @@ -38,14 +38,14 @@ if _have_feature "AUTO_BUF_REG"; then
> >       ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_f=
ixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> >       ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fa=
llback &
> >  fi
> >
> >  if _have_feature "PER_IO_DAEMON"; then
> > -     ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tas=
ks &
> > -     ublk_io_and_kill_daemon 256M -t loop -q 4 --nthreads 8 --per_io_t=
asks "${UBLK_BACKFILES[0]}" &
> > -     ublk_io_and_kill_daemon 256M -t stripe -q 4 --nthreads 8 --per_io=
_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > -     ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tas=
ks &
> > +     ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthreads 8 --=
per_io_tasks &
> > +     ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc --nthreads 8 =
--per_io_tasks "${UBLK_BACKFILES[0]}" &
> > +     ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --nthreads =
8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > +     ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --auto_zc_fallb=
ack --nthreads 8 --per_io_tasks &
>
> The last line needs `-z`, otherwise the following warning is dumped:
>
> ```
> # selftests: ublk: test_stress_04.sh
> # main: auto_zc_fallback is set but neither F_AUTO_BUF_REG nor F_SUPPORT_=
ZERO_COPY is enabled
> # stress_04 : [FAIL]
> ```

Yeah, duh! I swear I tested this... Oh, it's because I had revised
this patch following your initial feedback but replaced it with the
version from v1 right before sending it. Will fix.

Thanks,
Caleb
