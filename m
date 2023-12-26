Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74354E607
	for <linux-block@vger.kernel.org>; Tue, 26 Dec 2023 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="ZrdwpR8p"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5532b45c286so5166433a12.0
        for <linux-block@vger.kernel.org>; Tue, 26 Dec 2023 04:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703592865; x=1704197665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgFlNYVpTW4/LSUdsscecibsDCHhy6INDSaJkTsHmeY=;
        b=ZrdwpR8pCEzJiWHU8sTBieDw1/Waa5zyVylr6tla2Bg7waa/jfJPm8rkMEAho/C9ge
         9s1AXglsnV9076g69kdoDpn/Sf8aJiovCvSGhUxZBklbkFKK8bL5/wdgPAdYKDupdNay
         x/tR4OJpQFuCYhmS/ywqgeBgO/+MluSD6XsQYgFD1sT30dPUMn4o0O08hKUnQJNiOcFO
         Lb+cvRvJXFmrvmIX57zOV+mKqWcCsXRrAoCH4sCuK82xMDasQ14na/XKx4pUMg9eG71e
         h5A3bfcKOABv/emGpgqBR1eIrNVjHNGosGDIGfP06Fz1O8YfPWlD1I0qgDA/RcX10Ip9
         EAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703592865; x=1704197665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgFlNYVpTW4/LSUdsscecibsDCHhy6INDSaJkTsHmeY=;
        b=BmSEelfT0d3dZha5szqg2Sy9rkZoGk3UHLd6BXbRsvnPO18xLCEZxHxWZPBdI119T+
         T+4vZaF9TQ5jM65lrYh+MhTpyYSxUQPZwHH9zbOivcgX8mK7QrVXO6ps07KaXuRI/mZA
         Mm0ObsLD7zKJ2QAez1FtnTHlwiBiuL1XrHcLufPVBAEtLAnbTUJbyS46je4G5jN008ZK
         OwZxQNLmc1QOiWusHhZ6lRW/e+rnARrIGaSp+a31OQtLsxQlaPPgojXedUeOtvh8B14y
         Vnn12hRtqcdrvN4/hyW1PDeNPwPctHpoe15dqeL59QCLnrj0OyoLbLDDVavubp37Oxdv
         LBqA==
X-Gm-Message-State: AOJu0Yx9w3lpQY3kPe73sBucrA874aByZBfXDw6zrgFyp631EkCr5sbK
	T4pEqZ2U/EnuEpinICNdn6DCZS6wdAI9IzTLDed6ewTGi0VZ4A==
X-Google-Smtp-Source: AGHT+IHxzCgO2oCLfPXnR4/Me1mMAqfQos7RB3BFSZ2u3yzZCPtF4kJmY71gWFuDLOAwlb8zPxryR79r59mCSy96caI=
X-Received: by 2002:a17:907:1b12:b0:a26:ebc6:eb7e with SMTP id
 mp18-20020a1709071b1200b00a26ebc6eb7emr965572ejc.194.1703592864489; Tue, 26
 Dec 2023 04:14:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207043118.118158-1-fengli@smartx.com> <20231225092010-mutt-send-email-mst@kernel.org>
 <AB23804D-FF38-47B8-ADC6-C0A19B7083CC@smartx.com> <20231226040342-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231226040342-mutt-send-email-mst@kernel.org>
From: Li Feng <fengli@smartx.com>
Date: Tue, 26 Dec 2023 20:14:13 +0800
Message-ID: <CAHckoCyBxHd6Lc8UPh_3urSHz_eDj6jrm+c80+wKBmypzjvz+A@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 5:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Dec 26, 2023 at 05:01:40PM +0800, Li Feng wrote:
> > Hi MST and paolo,
> >
> > mq-deadline is good for slow media, and none is good for high-speed med=
ia.
> > It depends on how the community views this issue. When virtio-blk adopt=
s
> > multi-queue,it automatically changes from deadline to none, which is no=
t
> > uniform here.
>
> It's not virtio-blk changing though, it's linux doing that, right?
> Is virtio-blk special somehow?
>
Yes, it=E2=80=99s the common code path.

Each block driver has a chance to set the default none scheduler, like loop=
,
it has set the none as the default scheduler.

https://lkml.kernel.org/stable/20230809103647.895397540@linuxfoundation.org=
/

> > I don't have ideas right now to answer Christoph/Paolo's question.
> >
> > Thanks,
> > Li
>
> --
> MST
>
