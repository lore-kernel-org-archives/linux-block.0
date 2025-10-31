Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53033274B34;
	Fri, 31 Oct 2025 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761925998; cv=none; b=oM9W8K5o8e0CTMzfs1MyB/BqYxWXy8HbyToWReYD5IY+g3hfnj2oFV2aejA/aNqyltIW+021gqj6BafWCY4tFBvG2BOkLoM5A0q8KuUXkdw0DWH6iSECtYQsydhW4p6MfC4TAip5uKmppp4zJjqTOlKwTDsFDO0aXpaIj6Vkjd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761925998; c=relaxed/simple;
	bh=RJ1YrKgqM/dtb9esJxnIEJymS76b4QP/mrm/2hDtGeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJYvPibh6ziMIfrBaAAL8vfChnnmUjyqEzElAWdd9ICp2AWSs/8gaD0eeN+KnaAGGNE0qTeATXiEwgmc168TMoBEWF6tC7x4Eyrmdqruc0b7xeTOiMJK/AULlJLWXYOHSX4LgHUxpbgmrmtECamEIcG4QQX/nhs2jtzJQ/VuDcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJjkcisB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJjkcisB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C09C4CEE7;
	Fri, 31 Oct 2025 15:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761925998;
	bh=RJ1YrKgqM/dtb9esJxnIEJymS76b4QP/mrm/2hDtGeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TJjkcisBPllWjSHrS4u3XeEDvyyiT3V1LXscu4udIO2CGVkQgj2FDLwmlunc29Z8R
	 tc2xqavx/RzC/ihkEaZwNMQVkrBYi/R9yI2dqsqIeBkqEN35xdmFv9G38mGLeVRDbi
	 s0nzTmssAv7sWBN8MjQwnx/TkZjsxONVW9MMHwzG6xO04pt2QSicI6waKmsufSK3xF
	 GjzosPNzvOJXPtsrioGB/CuCAXLV+kYKoUoI4cKGVrijljOvizKR2el0lW2mtMCXei
	 O5q/qF+xnnLXRre8UjZ1TAzZLPyLjE7pEZpfy9gGwJzgbKPlLQuKPyrU7EUQhZE4cj
	 9LSSlMzD8OtRQ==
Date: Fri, 31 Oct 2025 16:53:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [GIT PULL] Block fixes for 6.18-rc3
Message-ID: <20251031-erzfeind-verausgaben-03d00274429a@brauner>
References: <37fb8720-bee9-43b7-b0ff-0214a8ad33a2@kernel.dk>
 <CAHk-=wgZ9x+yxUB9sjete2s9KBiHnPm2+rcwiWNXhx-rpcKxcw@mail.gmail.com>
 <20251031-zerkratzen-privileg-77a7fb326e34@brauner>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251031-zerkratzen-privileg-77a7fb326e34@brauner>

On Fri, Oct 31, 2025 at 04:43:54PM +0100, Christian Brauner wrote:
> On Fri, Oct 24, 2025 at 01:31:11PM -0700, Linus Torvalds wrote:
> > [ Adding LSM people. Also Christian, because he did the cred refcount
> 
> Sorry, late to the party. I was working on other stuf. Let me see...
> 
> > cleanup with override_creds() and friends last year, and I'm
> > suggesting taking that one step further ]
> > 
> > On Fri, 24 Oct 2025 at 06:58, Jens Axboe <axboe@kernel.dk> wrote:
> > >
> > > Ondrej Mosnacek (1):
> > >       nbd: override creds to kernel when calling sock_{send,recv}msg()
> > 
> > I've pulled this, but looking at the patch, I note that more than half
> > the patch - 75% to be exact - is just boilerplate for "I need to
> > allocate the kernel cred and deal with error handling there".
> > 
> > It literally has three lines of new actual useful code (two statements
> > and one local variable declaration), and then nine lines of the "setup
> > dance".
> > 
> > Which isn't wrong, but when the infrastructure boilerplate is three
> > times more than the actual code, it makes me think we should maybe
> > just get rid of the
> > 
> >     my_kernel_cred = prepare_kernel_cred(&init_task);
> > 
> > pattern for this use-case, and just let people use "init_cred"
> > directly for things like this.
> > 
> > Because that's essentially what that prepare_kernel_cred() thing
> > returns, except it allocates a new copy of said thing, so now you have
> > error handling and you have to free it after-the-fact.
> > 
> > And I'm not seeing that the extra error handling and freeing dance
> > actually buys us anything at all.
> > 
> > Now, some *other* users actually go on to change the creds: they want
> > that prepare_kernel_cred() dance because they then actually do
> > something else like using their own keyring or whatever (eg the NFS
> > idmap code or some other filesystem stuff).
> > 
> > So it's not like prepare_kernel_cred() is wrong, but in this kind of
> > case where people just go "I'm a driver with hardware access, I want
> > to do something with kernel privileges not user privileges", it
> > actually seems counterproductive to have extra code just to complicate
> > things.
> > 
> > Now, my gut feel is that if we just let people use 'init_cred'
> > directly, we should also make sure that it's always exposed as a
> > 'const struct cred' , but wouldn't that be a whole lot simpler and
> > more straightforward?
> > 
> > This is *not* the only use case of that.
> > 
> > We now have at least four use-cases of this "raw kernel cred" pattern:
> > core-dumping over unix domain socket, nbd, firmware loading and SCSI
> > target all do this exact thing as far as I can tell.
> > 
> > So  they all just want that bare kernel cred, and this interface then
> > forces it to do extra work instead of just doing
> > 
> >         old_cred = override_creds(&init_cred);
> >         ...
> >         revert_creds(old_cred);
> > 
> > and it ends up being extra code for allocating and freeing that copy
> > of a cred that we already *had* and could just have used directly.
> > 
> > I did just check that making 'init_cred' be const
> 
> Hm, two immediate observations before I go off and write the series.
> 
> (1) The thing is that init_cred would have to be exposed to modules via
>     EXPORT_SYMBOL() for this to work. It would be easier to just force
>     the use of init_task->cred instead.
> 
>     That pointer deref won't matter in the face of the allocations and
>     refcounts we wipe out with this. Then we should also move init_cred
>     to init/init_task.c and make it static const. Nobody really needs it
>     currently.
> 
> (2) I think the plain override_creds() would work but we can do better.
>     I envision we can leverage CLASS() to completely hide any access to
>     init_cred and force a scope with kernel creds.
> 
> /me goess off to write that up.
> 
> Ok, so I have it and it survives the coredump socket tests. They are a
> prime example for this sort of thing. Any unprivileged task needs to be
> able to connect to the coredump socket when it coredumps so we override
> credentials only for the path lookup. With my patchset this becomes:
> 
>         if (flags & SOCK_COREDUMP) {
>                 struct path root;
> 
>                 task_lock(&init_task);
>                 get_fs_root(init_task.fs, &root);
>                 task_unlock(&init_task);
> 
>                 scoped_with_kernel_creds() 
> 			err = vfs_path_lookup(root.dentry, root.mnt, sunaddr->sun_path,
> 					      LOOKUP_BENEATH | LOOKUP_NO_SYMLINKS |
> 					      LOOKUP_NO_MAGICLINKS, &path);
>                 path_put(&root);
>                 if (err)
>                         goto fail;
>         } else {
> 
> Patches appended.

> Date: Fri, 31 Oct 2025 16:37:35 +0100
> From: Christian Brauner <brauner@kernel.org>
> To: Christian Brauner <brauner@kernel.org>
> Subject: [PATCH 0/6] creds: add {scoped_}with_kernel_creds()
> Message-Id: <20251031-work-creds-init_cred-v1-0-cbf0400d6e0e@kernel.org>

Needs one diff I forgot to fold:

diff --git a/init/init_task.c b/init/init_task.c
index 68059eac9a1e..15288e62334f 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -62,6 +62,9 @@ unsigned long init_shadow_call_stack[SCS_SIZE / sizeof(long)] = {
 };
 #endif

+/* init to 2 - one for init_task, one to ensure it is never freed */
+static struct group_info init_groups = { .usage = REFCOUNT_INIT(2) };
+
 /*
  * The initial credentials for the initial task
  */
diff --git a/kernel/cred.c b/kernel/cred.c
index 9ff0b349b80b..ac87ed9d43b1 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -35,9 +35,6 @@ do {                                                                  \

 static struct kmem_cache *cred_jar;

-/* init to 2 - one for init_task, one to ensure it is never freed */
-static struct group_info init_groups = { .usage = REFCOUNT_INIT(2) };
-
 /*
  * The RCU callback to actually dispose of a set of credentials
  */

