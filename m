Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC83A2D3212
	for <linux-block@vger.kernel.org>; Fri, 24 Oct 2025 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337893; cv=none; b=f+jKdYVnR9KKTJE3KwrRj+Lx0e3+V3hxxFRiZFU3mpE54YKq+IHDS53Rsw/iRLod2X38kFFWFNmGwziSGqyrP30Bb9JjP5qS7oofmifVNZRH7JLfMl1DSCdjt4ojLQkJsCMrf3oOYNA9THUuVsryULUrG5uezL2PDrZ4E7Af898=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337893; c=relaxed/simple;
	bh=YLsDVmBRFUzk4uFHLNXj50aYnzyO7d5mx0WZXJ2eLJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMIAPomDZ81+JC/erakP+0aoMyEOe/Sh/0CxNkf3rdELwnjlA1CjGMjnRbwMzmtQ38dR4RkbS6g78pCZrETPeKsAUhdDQ7jvUT/ezv3e67wPGX1hNHJaNSh5zYzJjpin09EVoTIRY2EFwDCnQEp9BbxeL8LnCuHrlbmzfyxp260=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hv0CJmW+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hv0CJmW+"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6d3340dc2aso512267566b.0
        for <linux-block@vger.kernel.org>; Fri, 24 Oct 2025 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761337889; x=1761942689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BFuzQTMQA5rTZOkoXKW3L8u+HJJavRaRvHnpTIXo3kA=;
        b=hv0CJmW++3eKf3G9Q/2DIKKT9njJRsLOp3vI4RnVQlRXR2IM/VUgTPFH98NCEzaVVD
         pATzOaCw6ZZFoX9esHfYlbLMpA6CXBeYFRn7WHMOlx8yJ5OTj4NMTWMW3bz5viKGX5mV
         KVrelyju+qY2/rlE408i/1niTzoYocyWQev5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761337889; x=1761942689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFuzQTMQA5rTZOkoXKW3L8u+HJJavRaRvHnpTIXo3kA=;
        b=berToPNdKvBGICHtb9L1Yn0CRyjFK67N4gr27UiSCXlF9hqpxIp6PMX4itGiUtPpe8
         0gcqOJKUPBQrKXt70Y1O03gLaQGqN1rnqaLjGqJznuoGq0RzmM+NHQwYCBkHxrpqQIFR
         y62BgZbAZ9qESO9SNDNmrMhPKjx9VmUo37ZrXnuWiXAByS+wAX0JNewHc31sln+GI2mC
         TBS/Tf0P/0ztjvX6XCijIETNdV3EQAOEFvXlPPOL8o+ptBPUDolIM668amljx1ft3CfI
         J9M5xjUuNfwVuqF5rfNqLSiL2WxhlE7JdbJetTyBxIRWv6R+0DfiiMoEKHSRz23sb0Hv
         iYOw==
X-Gm-Message-State: AOJu0YxAYi2PBikNs04mekR3c3scV2yUK9nInG4qnFk5mwreb+3oDSBy
	ntkmRmwEgPze8eHAhM1IanpX76gQZ0JD04VvD1+TITmGNHl4CUzn2Xak/4qmVXN2lc7bzIy6H2C
	jDET076Y=
X-Gm-Gg: ASbGnctO/h1FjvVElHu0wxd1eGY1eKU2e7xg9TkJZ4kPzeVakLy5Kk0DTri+56PeITW
	vhohvmQQXTmSXtnoq37WH1TQ92XFMvvsdlJvB7wSAanBojpKT/wz93YLTVM0kJWAfLkiSbpmvsj
	Tz9b/by4Gr06ncx78RUDonBfa6I+FF/gFaR/MHhFf4M0Yp+rYUKoMBSh25IJQ22Olj6tb0YUKq6
	gGIEGrD6En6hSkyJFtw43B8npL5Xw6mp+KRqFWpK8ghLWFbdJNuDAztrb8HdBtv5Kj13yfWS+iR
	uTGMpWZZDWUBmBCj0BaBC+7yPFRUmJGNpGCrkPJBZvbJ4IqW9SwkfVCnW1GRUkczhPXjg1xW9Ov
	kFE8ysjGpn0+mLmBjteYp3zdjL2Kns6LMfhIvLpuD/FXtSGmLSVgYZe0VLRkQkVhFdsaHeQsy6Z
	qak/hd1W6t95PnLIdSeLDuHfjX9ITf3dSbB57lxwVMtQG7/nsNZQ==
X-Google-Smtp-Source: AGHT+IE1SBKTkw09LwlZy5nICrD1DHFAKfApgT+CTyVe5WbXWgXeKtSUfdTmekG4Pv9wLIzreWeDgA==
X-Received: by 2002:a17:906:919:b0:b5c:6e0b:3706 with SMTP id a640c23a62f3a-b6d6bb1db21mr370087366b.13.1761337888594;
        Fri, 24 Oct 2025 13:31:28 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853077d2sm12047866b.3.2025.10.24.13.31.27
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 13:31:27 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c12ff0c5eso5068291a12.0
        for <linux-block@vger.kernel.org>; Fri, 24 Oct 2025 13:31:27 -0700 (PDT)
X-Received: by 2002:a05:6402:3511:b0:63b:ec3c:ee32 with SMTP id
 4fb4d7f45d1cf-63e5eb18f2dmr3477528a12.11.1761337887233; Fri, 24 Oct 2025
 13:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <37fb8720-bee9-43b7-b0ff-0214a8ad33a2@kernel.dk>
In-Reply-To: <37fb8720-bee9-43b7-b0ff-0214a8ad33a2@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 Oct 2025 13:31:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZ9x+yxUB9sjete2s9KBiHnPm2+rcwiWNXhx-rpcKxcw@mail.gmail.com>
X-Gm-Features: AWmQ_bk4uIZgtxqK_hz679cw5uXq-Z_oOrdasW-TDydWDYZqpoDShTeWLYqsq6s
Message-ID: <CAHk-=wgZ9x+yxUB9sjete2s9KBiHnPm2+rcwiWNXhx-rpcKxcw@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 6.18-rc3
To: Jens Axboe <axboe@kernel.dk>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

[ Adding LSM people. Also Christian, because he did the cred refcount
cleanup with override_creds() and friends last year, and I'm
suggesting taking that one step further ]

On Fri, 24 Oct 2025 at 06:58, Jens Axboe <axboe@kernel.dk> wrote:
>
> Ondrej Mosnacek (1):
>       nbd: override creds to kernel when calling sock_{send,recv}msg()

I've pulled this, but looking at the patch, I note that more than half
the patch - 75% to be exact - is just boilerplate for "I need to
allocate the kernel cred and deal with error handling there".

It literally has three lines of new actual useful code (two statements
and one local variable declaration), and then nine lines of the "setup
dance".

Which isn't wrong, but when the infrastructure boilerplate is three
times more than the actual code, it makes me think we should maybe
just get rid of the

    my_kernel_cred = prepare_kernel_cred(&init_task);

pattern for this use-case, and just let people use "init_cred"
directly for things like this.

Because that's essentially what that prepare_kernel_cred() thing
returns, except it allocates a new copy of said thing, so now you have
error handling and you have to free it after-the-fact.

And I'm not seeing that the extra error handling and freeing dance
actually buys us anything at all.

Now, some *other* users actually go on to change the creds: they want
that prepare_kernel_cred() dance because they then actually do
something else like using their own keyring or whatever (eg the NFS
idmap code or some other filesystem stuff).

So it's not like prepare_kernel_cred() is wrong, but in this kind of
case where people just go "I'm a driver with hardware access, I want
to do something with kernel privileges not user privileges", it
actually seems counterproductive to have extra code just to complicate
things.

Now, my gut feel is that if we just let people use 'init_cred'
directly, we should also make sure that it's always exposed as a
'const struct cred' , but wouldn't that be a whole lot simpler and
more straightforward?

This is *not* the only use case of that.

We now have at least four use-cases of this "raw kernel cred" pattern:
core-dumping over unix domain socket, nbd, firmware loading and SCSI
target all do this exact thing as far as I can tell.

So  they all just want that bare kernel cred, and this interface then
forces it to do extra work instead of just doing

        old_cred = override_creds(&init_cred);
        ...
        revert_creds(old_cred);

and it ends up being extra code for allocating and freeing that copy
of a cred that we already *had* and could just have used directly.

I did just check that making 'init_cred' be const

  --- a/include/linux/init_task.h
  +++ b/include/linux/init_task.h
  @@ -28 +28 @@ extern struct nsproxy init_nsproxy;
  -extern struct cred init_cred;
  +extern const struct cred init_cred;
  --- a/kernel/cred.c
  +++ b/kernel/cred.c
  @@ -44 +44 @@ static struct group_info init_groups = { .usage =
REFCOUNT_INIT(2) };
  -struct cred init_cred = {
  +const struct cred init_cred = {

seems to build just fine and would seem to be the right thing to do
even if we *don't* expect people to use it. And override_creds() is
perfectly happy with a

Maybe there's some reason for that extra work that I'm not seeing and
thinking of? But it all smells like make-believe work to me that
probably has a historical reason for it, but doesn't seem to make a
lot of sense any more.

Hmm?

               Linus
