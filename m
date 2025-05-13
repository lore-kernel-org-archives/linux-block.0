Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDD81A3155
	for <linux-block@vger.kernel.org>; Tue, 13 May 2025 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747156170; cv=none; b=kv/Sde15B4Pozi2nma1GV3fx5qBKio8ntoUClnGSh+SrhqbXWOrYdh3YTykFyHBNha64jSBnYrV0gtQXSmRTas7CszhI79ZH0SH1CRWACksGU90CNXVyfZeXMWXoBpJhb34zebDScQAs2I0oIIQhPJlW9HsASt1v2wp7ZV95rDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747156170; c=relaxed/simple;
	bh=O9eEXJEU2Jbn/4o9ZAwJeJuGoNiHANTvaAhReTAmd8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pmjlbe6XBNpUA1Ieq8caYKCXx7sMSDnTDXG50jFyc1dY1fOv3ALjVSHfcZFJx6GSvKTkVFU+iJTNm9IgCmrOF1kICHRql8HWgItRsklui4mRdw24Ct0sYFdkVSkmoJD0VJ8BPPp1dPBy96vNf2WwCnhIeEDTQ3aPtHth1KVFsZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fzQIlfq9; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fzQIlfq9"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b078bb16607so418268a12.2
        for <linux-block@vger.kernel.org>; Tue, 13 May 2025 10:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747156167; x=1747760967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9eEXJEU2Jbn/4o9ZAwJeJuGoNiHANTvaAhReTAmd8k=;
        b=fzQIlfq9RTP/wNXGIL86UKN1qt/8G/EHy1SiWddBDs9cjgIgLkVXKuGbAt/YgnOqXC
         CHJi0JvFUQ7bTF3E+guwCK+yjMIZWelpMAghIJmCRyXHW23V0m74ME2210bU3ncStAsr
         Zsb0PzZfY4hOxHv6L1qEX8wp6wdercLQ1Wsuy+amoOHrlXzx4NKMGp2MaO7W3Jh4p+Ph
         IKr8txALzxIgNLU+DJugMkH8jNDeLksU8GNohkk2uTp4ZTmy1unANKgn8A+q/ZNa2/ce
         5A1T353wrVtNM5t++wG8vHbc4ZqHk4ddF5yifQcAy2AT3USfU/tuFJY1biQqS0Sqbr46
         kdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747156167; x=1747760967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9eEXJEU2Jbn/4o9ZAwJeJuGoNiHANTvaAhReTAmd8k=;
        b=TgAJvc21dw5fZlwpd690HpmRZDC+Fsf0Ho/nkRfEqxl00pNdoqBasV59l84Q43j4XO
         IeUuEjWhcnE6pfckzI7W5USJz4vBKfGm61aasg3NTfm4Sxz1NrYr2Dn6IPqfqOJb8/gp
         akPolLXKmgnWwD/k6tTDtHgRH1LdrO/9tl+hli2JhGphiyS+J9RkyX97walnag3j7rH1
         3NGrTi69z/DGgKQ9nXz4ca5lj3aTn3HXVYMLSN/8Rnjj7ifae1sL1UU7ejr7GJ54ZDXe
         IeHAQKnfQULjzf2RYmH7tGBDC3uuaAR6E75G2N4m3iFJMgVNGwBSMiVx6HyEABA/XLH8
         YPWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1Zk/CLN68Qy4esvwlvigLes6FnlG1/aAm/0yCSYyGI9ftfP0wYWmUAhdwJY4Jz+B1PLGgbbJxWmXxpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXp5h8TZ9WdVIYCs7EWUSbphMT4n/FthALxP3OmQuLcFiHCaQ8
	H5N/gejqNxzqASuYDcDKHNpTm5FlWGC0gJkPXqaWNWKR7sKMHY2uQLa3MQyWKCo7q4BvjjJOcA5
	5ZbuvU63Qx8t2bhzB6q7cJWfS/twGQFU8Plv+cg==
X-Gm-Gg: ASbGncsIJD6VSLQrjAghJDjPZfEQjFBOvZTSw/3LuTYFcbjaA0LW6OUac2y7G+E7ZyV
	sTr5ZU/4bYvryA5FLENJmXiWXeLDOcAz/Ik+88InO7WygAxhYoA8knJum7iZSZwsQVQWY6T7J7p
	3L9TsUzvjAAQ9VLbV44eBUYOVbricU/M/z7xhd468gdQ==
X-Google-Smtp-Source: AGHT+IGy5vOEMJ++7nSx2rTK6WlyL+abivLEWUFq4sQO48usHh8aX+NlY0m+kUQDC5NsGQzK39T9wFF/FQlgjytM4fE=
X-Received: by 2002:a17:902:ef06:b0:21b:b115:1dd9 with SMTP id
 d9443c01a7336-231980d7403mr1475075ad.5.1747156167393; Tue, 13 May 2025
 10:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509150611.3395206-1-ming.lei@redhat.com> <20250509150611.3395206-2-ming.lei@redhat.com>
 <CADUfDZqfEnOM1hmZJw7VTNUUu_zqf1fBcju_ZvDt9tNe3-KcHw@mail.gmail.com> <aCKt8ZLpZctP020J@fedora>
In-Reply-To: <aCKt8ZLpZctP020J@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 13 May 2025 10:09:14 -0700
X-Gm-Features: AX0GCFuO1Q3fdLeS0W0CQYM-BwXV4f3blIEBvBJ8M0M0rdazAewMEm7LuGDntJY
Message-ID: <CADUfDZo6T3mJmak3Rcf73=Pq-=RjH+rADZFSjffcJVSyxb-OWw@mail.gmail.com>
Subject: Re: [PATCH V3 1/6] ublk: allow io buffer register/unregister command
 issued from other task contexts
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 7:27=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Mon, May 12, 2025 at 10:39:57AM -0700, Caleb Sander Mateos wrote:
> > On Fri, May 9, 2025 at 8:06=E2=80=AFAM Ming Lei <ming.lei@redhat.com> w=
rote:
> > >
> > > `ublk_queue` is read only for io buffer register/unregister command. =
Both
> > > `ublk_io` and block layer request are read-only for IO buffer registe=
r/
> > > unregister command.
> > >
> > > So the two command can be issued from other task contexts.
> >
> > I mentioned this before in
> > https://lore.kernel.org/linux-block/CADUfDZqZ_9O7vUAYtxrrujWqPBuP05nBhC=
bzNuNsc9kJTmX2sA@mail.gmail.com/
> >
> > But UBLK_IO_(UN)REGISTER_IO_BUF still reads io->flags. So it would be
> > a race condition to handle it on a thread other than ubq_daemon, as
> > ubq_daemon may concurrently modify io->flags. If you do want to
> > support UBLK_IO_(UN)REGISTER_IO_BUF on other threads, the writes to
> > io->flags should use WRITE_ONCE() and the reads on other threads
> > should use READ_ONCE(). With those modifications, it should be safe
> > because __ublk_check_and_get_req() atomically checks the state of the
> > request and increments its reference count.
>
> UBLK_IO_(UN)REGISTER_IO_BUF just reads the flag, if
> UBLK_IO_FLAG_OWNED_BY_SRV is cleared, the OP is failed.
>
> Otherwise, __ublk_check_and_get_req() covers everything because both
> 'ublk_io' and 'request' are pre-allocation. The only race is that new
> recycled request buffer is registered, that is fine, because it can be
> treated as logic bug.
>
> So I think it isn't necessary to use READ_ONCE/WRITE_ONCE, or can you sho=
w
> what the exact issue is?

It's undefined behavior in C for a value to be concurrently accessed
by multiple threads, at least one of which is writing to it. I agree
the UB is unlikely to be exploited by the compiler or processor (at
least on x86 or ARM), but it is a theoretical possibility. At the very
least, KCSAN could detect a race condition here. But even without
evidence of observable bugs, I think we should strive to avoid
introducing UB, especially when it can be avoided fairly easily with
READ_ONCE() and WRITE_ONCE().

Best,
Caleb
