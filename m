Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386EF18DB20;
	Tue, 13 May 2025 01:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747100933; cv=none; b=aeRZRNF/JED0HHzPZZZ66bEU2+QSF6+HgY5N42fRloTas7xUZ4UqybujxTwpN4TKzJF59uu14ccLBZU63/3ZaSI+2iNMIbLfXvnwuFP/pTqcUgAel3TmPTa46M7VHGPNRF2NG1FfIY1gNiXOW9dBpAkbi3w7DBpadZTdRDfgR3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747100933; c=relaxed/simple;
	bh=x3TOf3D2FWDM+vKIdsFexUN5txpyfGA8qZQSZAZ1u7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXcNvWW4gnU7ETHrY+TC36386cIfXD4TAD650Nb88PSU1pttHmOLrJqwM2+GFjbY7VJQ59PmSjwk7kLl5dimIhiwKalmQ7IyAAlUHyavrEJBVC+t9lhJSsMWlg6tVYCP3ixTsnlwt2ku98TNzijrvnbkUkx8sep6PcC68E6KoQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Grat5Sfy; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Grat5Sfy"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d817bc6eb0so26565515ab.1;
        Mon, 12 May 2025 18:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747100931; x=1747705731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SW1vH0Jzp28bsUcst3vDejenUL61vJR3lM75Rj7bO1E=;
        b=Grat5SfyhmbSMZ/eU15gvjdR6iW2yLIqCNo9KGoNK4xDCIzDhZKqSu9VjUtP7b/maE
         0Trua0qAVJ6tLHIeio2/sMJkXiQmUNNe8OGBmOZEppwR77+Vwr9zIHSTxnXicAp3p6yc
         +g29MxL7SMejQPgJctaM5HrupRagJhVY3d/zuw3h/nvRgFBx92GNmHCFZOFO/GBWBTEy
         XMD6jGaeZHw5RKOD0atkwRl74zrkIOZSI59e2hKu59VAs9tPiXiHGcKGL6o178/HojfE
         L2ZqD4ybgh2eeKtsh2QCXXb24bgEIbadyLuR5QPd6Ct56mWbJ1yR/LSVMO+RaoS70SDA
         S2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747100931; x=1747705731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SW1vH0Jzp28bsUcst3vDejenUL61vJR3lM75Rj7bO1E=;
        b=evb1kwXAiMn27Yt6fCZn0HwzpcSlThKHws39i6NQDNLz8otFQztsbR6QMVsGExhkxw
         a2c+TgjDvodKKrBflDAVXwtIXBmXbV+av5E7khK757CkzNzApWm8H7h4qEIT0YSC1/w0
         A3BbtUV9G9YlG86dzW4MuefWwdvbwlmfp7LicEbbHrxErfzmxjARSY4udpQzgUNyG02W
         SgHOoQzoYru5+XAuNulAlbGaDAahjBzjclaA6fC0dkZ+MksBrWvA6WMyJWhcJvTznvWg
         4OjPIu831po0j08LOCnkwqjeg5AIaTKUwge3id1o+yzOEN3ZQ/qSWaFCmw7+w/tPj75n
         FcKw==
X-Forwarded-Encrypted: i=1; AJvYcCVKysogt+pWFX+qhOWWMmSLxEtOg9sBmA7EakYufGs7cNITRDfSoyrsriF1QsrHTpGlCEYMQjKf1EnPv1nL@vger.kernel.org, AJvYcCXgGqNAcdMNMXZYHkuuNOwdzG+gIyy76I2tiLNt654Rsk7R7/4lPOoWZfNSP2Di+ebtiplu7Ub1g6NQ7YFbpDH5exfS@vger.kernel.org, AJvYcCXmFKlTUNgL7C2U8n1wcuK9yaElKCHObtV+oIPPXYaIKIJmvYp/i/WeIOZpgDUAzoXEHK566Hx/3IBAfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdNVZj+0CNji3n9QipCKUOl+l779LYF6+iRB3DKNqK2EFVrij2
	7PtDpM7OLez+BAdAW4wxs4a0AUriZyroRhD5wvrUTmV00yrq3Lhe8KjiUyt4l+RKWus2JmB44w9
	bdIIwyqvFEs+P/H5Jh5ZfD5MVINc=
X-Gm-Gg: ASbGncth5lg2zWdIsh6phxKmJDP2GTJ1rVW72QD6H+3fW+3oY+Owl16QV55nzI4DGn4
	lfXWCo4+wCynbhegyS+qbg/ilXa0s1qb86l8Y9IivdK2NnWRFGsORUfFmlSdSbhjGZHefyu3Ala
	VIpzwk0ItGQx8WXW834LxcXYnKdAW7gARV
X-Google-Smtp-Source: AGHT+IHtCZvGHP0FlostcRVpw3BIL1zFyR5i25Fiv+uh+LoyA8D4ZkHvT9+lvD5OKFqShdni0Nm68GpXZBc1Y2DkqSE=
X-Received: by 2002:a05:6e02:152e:b0:3d0:47cf:869c with SMTP id
 e9e14a558f8ab-3da7e21350fmr163199335ab.19.1747100931046; Mon, 12 May 2025
 18:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512024935.64704-1-kerneljasonxing@gmail.com>
 <20250512024935.64704-3-kerneljasonxing@gmail.com> <20250512175156.7d3d4db53d40c7a34c1f68d6@linux-foundation.org>
In-Reply-To: <20250512175156.7d3d4db53d40c7a34c1f68d6@linux-foundation.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 13 May 2025 09:48:15 +0800
X-Gm-Features: AX0GCFu3dnfm7WHKsdIPBdU5to--emIww-Hx9wLCflP5g0dm6SEaFE2ROEHeUQM
Message-ID: <CAL+tcoDk2TFwAWPwBN+dQQ+guxe71F_R1rFX_f9wozjPpujBAQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] relayfs: introduce dump of relayfs statistics function
To: Andrew Morton <akpm@linux-foundation.org>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 8:51=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 12 May 2025 10:49:32 +0800 Jason Xing <kerneljasonxing@gmail.com>=
 wrote:
>
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > In this version, only support dumping the counter for buffer full and
> > implement the framework of how it works. Users MUST pass a valid @buf
> > with a valid @len that is required to be larger than RELAY_DUMP_BUF_MAX=
_LEN
> > to acquire which information indicated by @flags to dump.
> >
> > RELAY_DUMP_BUF_MAX_LEN shows the maximum len of the buffer if users
> > choose to dump all the values.
> >
> > Users can use this buffer to do whatever they expect in their own kerne=
l
> > module, say, print to console/dmesg or write them into the relay buffer=
.
> >
> > ...
> >
> > +/**
> > + *   relay_dump - dump statistics of the specified channel buffer
> > + *   @chan: the channel
> > + *   @buf: buf to store statistics
> > + *   @len: len of buf to check
> > + *   @flags: select particular information to dump
> > + */
> > +void relay_dump(struct rchan *chan, char *buf, int len, int flags)
>
> `size_t' is probably a more appropriate type for `len'.
>
> > +{
> > +     unsigned int i, full_counter =3D 0;
> > +     struct rchan_buf *rbuf;
> > +     int offset =3D 0;
> > +
> > +     if (!chan || !buf || flags & ~RELAY_DUMP_MASK)
> > +             return;
> > +
> > +     if (len < RELAY_DUMP_BUF_MAX_LEN)
> > +             return;
>
> So we left the memory at *buf uninitialized but failed to tell the
> caller this.  The caller will then proceed to use uninitialized memory.
>
> It's a programming error, so simply going BUG seems OK.

Are you suggesting that I should remove the above check because
developers should take care of the length of the buffer to write
outside of the relay_dump function? or use this instead:
WARN_ON_ONCE(len < RELAY_DUMP_BUF_MAX_LEN);
?

>
> > +     if (chan->is_global) {
> > +             rbuf =3D *per_cpu_ptr(chan->buf, 0);
> > +             full_counter =3D rbuf->stats.full;
> > +     } else {
> > +             for_each_possible_cpu(i) {
>
> I'm thinking that at this stage in the patch series, this should be
> for_each_online_cpu(), then adjust that in patch [5/5].

Point taken. Will change it.

>
> > +                     if ((rbuf =3D *per_cpu_ptr(chan->buf, i)))
> > +                             full_counter +=3D rbuf->stats.full;
> > +     }
> > +
> > +     if (flags & RELAY_DUMP_BUF_FULL)
> > +             offset +=3D snprintf(buf, sizeof(unsigned int), "%u", ful=
l_counter);
>
> This seems strange.  sizeof(unsigned int) has nothing to do with the
> number of characters which are consumed by expansion of "%u"?

Sorry, my bad. It should be:
offset +=3D snprintf(buf, len, "%u", full_counter);

Passing 'len' as the second parameter.

Thanks,
Jason

>
> > +
> > +     snprintf(buf + offset, 1, "\n");
> > +}
> > +EXPORT_SYMBOL_GPL(relay_dump);
> > +
> >  /**
> >   *   relay_file_open - open file op for relay files
> >   *   @inode: the inode
>
