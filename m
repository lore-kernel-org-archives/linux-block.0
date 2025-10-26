Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779272633;
	Sun, 26 Oct 2025 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761513007; cv=none; b=ZxafzxhvMPQnpR6h54wHzbV7Xovep3dyn6uSVTm0DS9kDEiEVeikfyc4qxgWJavM4qmYU5BSUwdIx2Sy262ppxb20RlaC5AkWwC99U5+x6jpUMhmtXLImVfstD8zbco6AsO3aw8YeRINNDnF30GDkhKWkcwBlcpvoRVzIOcSzYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761513007; c=relaxed/simple;
	bh=PBriKsO4tuCNyzAbjqejCaW1YZ+cNYR+Ve+QvRU2rvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVBzTRQfrhAY8PfxgfxUm9ubY5vETAcY6/pjs+ul580vVkNOI9eCBt+koI/goGXeQAlbNz1YPd9fpgFrY9Mn135mmNgtBNciFIdL0ZZb4s7ODcbqvM+kdqgM5gY7RyGNUxbyls8GneDSpUsFgwo1pLjcINQmIbUpGOHrO11osto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 20D969C6; Sun, 26 Oct 2025 16:09:57 -0500 (CDT)
Date: Sun, 26 Oct 2025 16:09:57 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <sergeh@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [GIT PULL] Block fixes for 6.18-rc3
Message-ID: <aP6OJTTWPQBkll56@mail.hallyn.com>
References: <37fb8720-bee9-43b7-b0ff-0214a8ad33a2@kernel.dk>
 <CAHk-=wgZ9x+yxUB9sjete2s9KBiHnPm2+rcwiWNXhx-rpcKxcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgZ9x+yxUB9sjete2s9KBiHnPm2+rcwiWNXhx-rpcKxcw@mail.gmail.com>

On Fri, Oct 24, 2025 at 01:31:11PM -0700, Linus Torvalds wrote:
> [ Adding LSM people. Also Christian, because he did the cred refcount
> cleanup with override_creds() and friends last year, and I'm
> suggesting taking that one step further ]
> 
> On Fri, 24 Oct 2025 at 06:58, Jens Axboe <axboe@kernel.dk> wrote:
> >
> > Ondrej Mosnacek (1):
> >       nbd: override creds to kernel when calling sock_{send,recv}msg()
> 
> I've pulled this, but looking at the patch, I note that more than half
> the patch - 75% to be exact - is just boilerplate for "I need to
> allocate the kernel cred and deal with error handling there".
> 
> It literally has three lines of new actual useful code (two statements
> and one local variable declaration), and then nine lines of the "setup
> dance".
> 
> Which isn't wrong, but when the infrastructure boilerplate is three
> times more than the actual code, it makes me think we should maybe
> just get rid of the
> 
>     my_kernel_cred = prepare_kernel_cred(&init_task);
> 
> pattern for this use-case, and just let people use "init_cred"
> directly for things like this.
> 
> Because that's essentially what that prepare_kernel_cred() thing
> returns, except it allocates a new copy of said thing, so now you have
> error handling and you have to free it after-the-fact.
> 
> And I'm not seeing that the extra error handling and freeing dance
> actually buys us anything at all.
> 
> Now, some *other* users actually go on to change the creds: they want
> that prepare_kernel_cred() dance because they then actually do
> something else like using their own keyring or whatever (eg the NFS
> idmap code or some other filesystem stuff).
> 
> So it's not like prepare_kernel_cred() is wrong, but in this kind of
> case where people just go "I'm a driver with hardware access, I want
> to do something with kernel privileges not user privileges", it
> actually seems counterproductive to have extra code just to complicate
> things.
> 
> Now, my gut feel is that if we just let people use 'init_cred'
> directly, we should also make sure that it's always exposed as a
> 'const struct cred' , but wouldn't that be a whole lot simpler and
> more straightforward?
> 
> This is *not* the only use case of that.
> 
> We now have at least four use-cases of this "raw kernel cred" pattern:
> core-dumping over unix domain socket, nbd, firmware loading and SCSI
> target all do this exact thing as far as I can tell.
> 
> So  they all just want that bare kernel cred, and this interface then
> forces it to do extra work instead of just doing
> 
>         old_cred = override_creds(&init_cred);
>         ...
>         revert_creds(old_cred);
> 
> and it ends up being extra code for allocating and freeing that copy
> of a cred that we already *had* and could just have used directly.
> 
> I did just check that making 'init_cred' be const
> 
>   --- a/include/linux/init_task.h
>   +++ b/include/linux/init_task.h
>   @@ -28 +28 @@ extern struct nsproxy init_nsproxy;
>   -extern struct cred init_cred;
>   +extern const struct cred init_cred;
>   --- a/kernel/cred.c
>   +++ b/kernel/cred.c
>   @@ -44 +44 @@ static struct group_info init_groups = { .usage =
> REFCOUNT_INIT(2) };
>   -struct cred init_cred = {
>   +const struct cred init_cred = {
> 
> seems to build just fine and would seem to be the right thing to do
> even if we *don't* expect people to use it. And override_creds() is
> perfectly happy with a
> 
> Maybe there's some reason for that extra work that I'm not seeing and
> thinking of? But it all smells like make-believe work to me that

The keychains are all NULL and won't be allocated (by init) without
copying a new cred, right?  And it seems like smack, selinux, and
apparmor at least each set the security field to a copy of the
daemon's.  Now, in theory, some LSM *could* come by and try to merge
current's info with init's, but that would probably be misguided.

So this does seem like it should work.

> probably has a historical reason for it, but doesn't seem to make a
> lot of sense any more.
> 
> Hmm?
> 
>                Linus
