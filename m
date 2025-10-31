Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC4B2BFC85;
	Fri, 31 Oct 2025 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761925438; cv=none; b=b/Uh9k8Dcjc6m1u7Qs45CvwXXYhW6pYR09kj5sxCPJ2Dg+0FSDRsjHIAD8K5UTM8msKB+8tHUwG1TNu3nz4lrMLK7UFSAe2H7VzpM18o6Vg8BfJ1o9yhAEOEhaohk+RFTEX3PzDj9F+DhbJtbgAoMvLiyCHOJw3Xs9YBMY26j8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761925438; c=relaxed/simple;
	bh=7mo9W31mSWYgZJr/x5zLFZVLILOSUMs6bNPXC0NCbiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lx7RipBO0dUzit10qMN7E8ZKHN9TEYwxILTNAK9cHwUwN3/+I/81HnJetVcpre2WeuX/t7ctnP82+dID6Sj2wL0nzPO8iRGl1hxuVld6PjSghUPn8yUjM60Ym5juH7RRnYBJ1ml7ltGggIOQKoUUjkuNL9KU5QD2EGN9O69Rva4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyItrCRI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyItrCRI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CA0C4CEE7;
	Fri, 31 Oct 2025 15:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761925438;
	bh=7mo9W31mSWYgZJr/x5zLFZVLILOSUMs6bNPXC0NCbiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fyItrCRI4ljv2D+tSSKUaee4vuqhVsx1kJWrW3/qFHd3x45YIMXTM6DYoY1aQlfUL
	 /eWuJd3VgffsryDtbKY2fJUGptND9uOJGUVp2APb0QzrrorN43vifFemp/1QchcsIQ
	 owc8X4wf/cnG2m5Py2exVwqTZM//ug1auUL5XSAocm0Ck7HYhfYPJ9iBqamyMenAOa
	 noASN1ipBw+CsGAju6y+bfZkMO0o+9kaphQY23t1kdcSyzpMPWA87T7ly8eWbLvO2y
	 OkIQtMjjchy/ZSVnlibfMldENZ6vLKTH5xppHuEEWX7FyCuAeIkKrKcfFd6Ky4ztfH
	 0iXTvRQfP47WQ==
Date: Fri, 31 Oct 2025 16:43:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [GIT PULL] Block fixes for 6.18-rc3
Message-ID: <20251031-zerkratzen-privileg-77a7fb326e34@brauner>
References: <37fb8720-bee9-43b7-b0ff-0214a8ad33a2@kernel.dk>
 <CAHk-=wgZ9x+yxUB9sjete2s9KBiHnPm2+rcwiWNXhx-rpcKxcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bfhe7hunbxaimnt2"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgZ9x+yxUB9sjete2s9KBiHnPm2+rcwiWNXhx-rpcKxcw@mail.gmail.com>


--bfhe7hunbxaimnt2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Oct 24, 2025 at 01:31:11PM -0700, Linus Torvalds wrote:
> [ Adding LSM people. Also Christian, because he did the cred refcount

Sorry, late to the party. I was working on other stuf. Let me see...

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

Hm, two immediate observations before I go off and write the series.

(1) The thing is that init_cred would have to be exposed to modules via
    EXPORT_SYMBOL() for this to work. It would be easier to just force
    the use of init_task->cred instead.

    That pointer deref won't matter in the face of the allocations and
    refcounts we wipe out with this. Then we should also move init_cred
    to init/init_task.c and make it static const. Nobody really needs it
    currently.

(2) I think the plain override_creds() would work but we can do better.
    I envision we can leverage CLASS() to completely hide any access to
    init_cred and force a scope with kernel creds.

/me goess off to write that up.

Ok, so I have it and it survives the coredump socket tests. They are a
prime example for this sort of thing. Any unprivileged task needs to be
able to connect to the coredump socket when it coredumps so we override
credentials only for the path lookup. With my patchset this becomes:

        if (flags & SOCK_COREDUMP) {
                struct path root;

                task_lock(&init_task);
                get_fs_root(init_task.fs, &root);
                task_unlock(&init_task);

                scoped_with_kernel_creds() 
			err = vfs_path_lookup(root.dentry, root.mnt, sunaddr->sun_path,
					      LOOKUP_BENEATH | LOOKUP_NO_SYMLINKS |
					      LOOKUP_NO_MAGICLINKS, &path);
                path_put(&root);
                if (err)
                        goto fail;
        } else {

Patches appended.

--bfhe7hunbxaimnt2
Content-Type: message/rfc822
Content-Disposition: attachment;
	filename="0000-creds-add-scoped_-with_kernel_creds.eml"

From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/6] creds: add {scoped_}with_kernel_creds()
Date: Fri, 31 Oct 2025 16:37:35 +0100
Message-Id: <20251031-work-creds-init_cred-v1-0-cbf0400d6e0e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL/XBGkC/x3MQQ7CIBCF4as0sxbD0ELBqxhjgBktMVIDjZo0v
 bvU3fsW71+hcklc4dStUPidappzAx46iJPPdxaJmkFJpVH2KD5zeYhYmKpIOS3XfQoKTmvjR0l
 mhHZ9Fb6l7z97vjQHX1mE4nOc9tjT14XLkZRFq3HkfrCGEKMLpLWPvmccpHY8ROOsNbBtP4HZa
 o+oAAAA
X-Change-ID: 20251031-work-creds-init_cred-db9556a70d67
To: Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HsP2dd8JAptP8KVlcTHfMx9+wuuQrSvwMSX8Kshmyz4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSyXN/fn7bzyfJaJwXONyaaysvLDvDm3X/ef/KKKMs+5
 t7GhdOXd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkax0jw6XZstLp94y8KhuN
 uDanv7WylOnRM83f+/ty3rmOcKtpqQz/owxZ3OW1jnd92hqht2K+8HwL6Znqfdpb3M4+kzya87W
 NFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't needlessly duplicate the initial credentials just to briefly use
them. Avoid all that work and add guards that hide all this away.

Note, using init_task in the macros to get at the credentials has the
advantage that we don't actually need to export init_cred to modules
such as nbd.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (6):
      cred: add {scoped_}with_kernel_creds
      creds: make init_cred static
      firmware: don't copy kernel creds
      nbd: don't copy kernel creds
      target: don't copy kernel creds
      unix: don't copy creds

 drivers/base/firmware_loader/main.c   | 59 +++++++++++++++--------------------
 drivers/block/nbd.c                   | 17 ++--------
 drivers/target/target_core_configfs.c | 14 ++-------
 include/linux/cred.h                  | 25 +++++++++++++++
 include/linux/init_task.h             |  1 -
 init/init_task.c                      | 24 ++++++++++++++
 kernel/cred.c                         | 24 --------------
 net/unix/af_unix.c                    | 17 +++-------
 security/keys/process_keys.c          |  2 +-
 9 files changed, 83 insertions(+), 100 deletions(-)
---
base-commit: d2818517e3486d11c9bd55aca3e14059e4c69886
change-id: 20251031-work-creds-init_cred-db9556a70d67


--bfhe7hunbxaimnt2
Content-Type: message/rfc822
Content-Disposition: attachment;
	filename="0001-cred-add-scoped_-with_kernel_creds.eml"

From: Christian Brauner <brauner@kernel.org>
Date: Fri, 31 Oct 2025 16:37:36 +0100
Subject: [PATCH 1/6] cred: add {scoped_}with_kernel_creds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-work-creds-init_cred-v1-1-cbf0400d6e0e@kernel.org>
References: <20251031-work-creds-init_cred-v1-0-cbf0400d6e0e@kernel.org>
In-Reply-To: <20251031-work-creds-init_cred-v1-0-cbf0400d6e0e@kernel.org>
To: Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1597; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JJZMKIinjiUd86Z4wDJfBRVFzS4TfRALpvKq+hJMX3I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSyXN/fPdPxzjXGY1Zhy1+fv/k0e4mCb+S3cwXd++/Ne
 zel/PGEwx2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQAT+fuZ4TfbnaOFWTa/HHr+
 svzrePLY89j+C0u2LWSpt6sOvfM+eb0Pwz9bg5qziRv4zPT/LX7awMJ69Mwm2yTVxqxj/sHys7e
 WlXACAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a new CLASS(with_kernel_creds) allowing code to run with kernel
creds without having to duplicate them first. Only use the CLASS() never
the plain helpers!

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/cred.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 89ae50ad2ace..8a8d6b3fbadb 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -20,6 +20,8 @@
 struct cred;
 struct inode;
 
+extern struct task_struct init_task;
+
 /*
  * COW Supplementary groups list
  */
@@ -180,6 +182,29 @@ static inline const struct cred *revert_creds(const struct cred *revert_cred)
 	return rcu_replace_pointer(current->cred, revert_cred, 1);
 }
 
+static inline const struct cred *__assume_kernel_creds(void)
+{
+	return rcu_replace_pointer(current->cred, init_task.cred, 1);
+}
+
+static inline void __yield_kernel_creds(const struct cred *revert_cred)
+{
+	WARN_ON_ONCE(current->cred != init_task.cred);
+	rcu_replace_pointer(current->cred, revert_cred, 1);
+}
+
+DEFINE_CLASS(with_kernel_creds,
+	     const struct cred *,
+	     __yield_kernel_creds(_T),
+	     __assume_kernel_creds(), void)
+
+#define with_kernel_creds() \
+	CLASS(with_kernel_creds, __UNIQUE_ID(cred))()
+
+#define scoped_with_kernel_creds() \
+	for (CLASS(with_kernel_creds, __UNIQUE_ID(cred))(), \
+	     *__p = (void *)1; __p; __p = NULL)
+
 /**
  * get_cred_many - Get references on a set of credentials
  * @cred: The credentials to reference

-- 
2.47.3


--bfhe7hunbxaimnt2
Content-Type: message/rfc822
Content-Disposition: attachment;
	filename="0002-creds-make-init_cred-static.eml"

From: Christian Brauner <brauner@kernel.org>
Date: Fri, 31 Oct 2025 16:37:37 +0100
Subject: [PATCH 2/6] creds: make init_cred static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-work-creds-init_cred-v1-2-cbf0400d6e0e@kernel.org>
References: <20251031-work-creds-init_cred-v1-0-cbf0400d6e0e@kernel.org>
In-Reply-To: <20251031-work-creds-init_cred-v1-0-cbf0400d6e0e@kernel.org>
To: Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=3522; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yIEP8T60qiz0z5zBhN9+5SgyIUpbZVyGFw7L4GzaNEY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSyXN+vfiZ6WWCfyOyov4xBDN4pb3s0Qp1SJsqy1ARP8
 Pi3SJ67o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKp4gz/LNZr59zfznq7kvXa
 hcqCM0zSZ3u4TlTP71edKTffVj89mJHhvfGljv2MYlfazHgEGlr//+NnX3NsTe6fhtf7qqauXKD
 DBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

There's zero need to expose struct init_cred.
The very few places that need direct access can just go through
init_task and be done with it.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/init_task.h    |  1 -
 init/init_task.c             | 24 ++++++++++++++++++++++++
 kernel/cred.c                | 24 ------------------------
 security/keys/process_keys.c |  2 +-
 4 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index bccb3f1f6262..a6cb241ea00c 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -25,7 +25,6 @@
 extern struct files_struct init_files;
 extern struct fs_struct init_fs;
 extern struct nsproxy init_nsproxy;
-extern struct cred init_cred;
 
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 #define INIT_PREV_CPUTIME(x)	.prev_cputime = {			\
diff --git a/init/init_task.c b/init/init_task.c
index a55e2189206f..68059eac9a1e 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -62,6 +62,30 @@ unsigned long init_shadow_call_stack[SCS_SIZE / sizeof(long)] = {
 };
 #endif
 
+/*
+ * The initial credentials for the initial task
+ */
+static const struct cred init_cred = {
+	.usage			= ATOMIC_INIT(4),
+	.uid			= GLOBAL_ROOT_UID,
+	.gid			= GLOBAL_ROOT_GID,
+	.suid			= GLOBAL_ROOT_UID,
+	.sgid			= GLOBAL_ROOT_GID,
+	.euid			= GLOBAL_ROOT_UID,
+	.egid			= GLOBAL_ROOT_GID,
+	.fsuid			= GLOBAL_ROOT_UID,
+	.fsgid			= GLOBAL_ROOT_GID,
+	.securebits		= SECUREBITS_DEFAULT,
+	.cap_inheritable	= CAP_EMPTY_SET,
+	.cap_permitted		= CAP_FULL_SET,
+	.cap_effective		= CAP_FULL_SET,
+	.cap_bset		= CAP_FULL_SET,
+	.user			= INIT_USER,
+	.user_ns		= &init_user_ns,
+	.group_info		= &init_groups,
+	.ucounts		= &init_ucounts,
+};
+
 /*
  * Set up the first task table, touch at your own risk!. Base=0,
  * limit=0x1fffff (=2MB)
diff --git a/kernel/cred.c b/kernel/cred.c
index dbf6b687dc5c..9ff0b349b80b 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -38,30 +38,6 @@ static struct kmem_cache *cred_jar;
 /* init to 2 - one for init_task, one to ensure it is never freed */
 static struct group_info init_groups = { .usage = REFCOUNT_INIT(2) };
 
-/*
- * The initial credentials for the initial task
- */
-struct cred init_cred = {
-	.usage			= ATOMIC_INIT(4),
-	.uid			= GLOBAL_ROOT_UID,
-	.gid			= GLOBAL_ROOT_GID,
-	.suid			= GLOBAL_ROOT_UID,
-	.sgid			= GLOBAL_ROOT_GID,
-	.euid			= GLOBAL_ROOT_UID,
-	.egid			= GLOBAL_ROOT_GID,
-	.fsuid			= GLOBAL_ROOT_UID,
-	.fsgid			= GLOBAL_ROOT_GID,
-	.securebits		= SECUREBITS_DEFAULT,
-	.cap_inheritable	= CAP_EMPTY_SET,
-	.cap_permitted		= CAP_FULL_SET,
-	.cap_effective		= CAP_FULL_SET,
-	.cap_bset		= CAP_FULL_SET,
-	.user			= INIT_USER,
-	.user_ns		= &init_user_ns,
-	.group_info		= &init_groups,
-	.ucounts		= &init_ucounts,
-};
-
 /*
  * The RCU callback to actually dispose of a set of credentials
  */
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index b5d5333ab330..98ba8a7d3118 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -51,7 +51,7 @@ static struct key *get_user_register(struct user_namespace *user_ns)
 	if (!reg_keyring) {
 		reg_keyring = keyring_alloc(".user_reg",
 					    user_ns->owner, INVALID_GID,
-					    &init_cred,
+					    init_task.cred,
 					    KEY_POS_WRITE | KEY_POS_SEARCH |
 					    KEY_USR_VIEW | KEY_USR_READ,
 					    0,

-- 
2.47.3


--bfhe7hunbxaimnt2
Content-Type: message/rfc822
Content-Disposition: attachment;
	filename="0003-firmware-don-t-copy-kernel-creds.eml"

From: Christian Brauner <brauner@kernel.org>
Date: Fri, 31 Oct 2025 16:37:38 +0100
Subject: [PATCH 3/6] firmware: don't copy kernel creds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-work-creds-init_cred-v1-3-cbf0400d6e0e@kernel.org>
References: <20251031-work-creds-init_cred-v1-0-cbf0400d6e0e@kernel.org>
In-Reply-To: <20251031-work-creds-init_cred-v1-0-cbf0400d6e0e@kernel.org>
To: Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=3047; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9tjm4XZeA9U2CsZnmhKJeE6G6baMkmZUlI8RNcH+BO0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSyXD/AtfrdnOKAk7MbQx9Ya1fbiS8vn9I74apbr3OeV
 VhJpklURykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETWsDEyzPE//P1OitntKSYb
 5if0d02eYxsaJHVIQ+/n9ZiG84u3uzL80zf7coBb93T/mqeHHHb+e3eHMSLh36mZ6mzL0lj++53
 4xgQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

No need to copy kernel credentials.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/base/firmware_loader/main.c | 59 ++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 6942c62fa59d..bee3050a20d9 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -829,8 +829,6 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 		  size_t offset, u32 opt_flags)
 {
 	struct firmware *fw = NULL;
-	struct cred *kern_cred = NULL;
-	const struct cred *old_cred;
 	bool nondirect = false;
 	int ret;
 
@@ -871,45 +869,38 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 	 * called by a driver when serving an unrelated request from userland, we use
 	 * the kernel credentials to read the file.
 	 */
-	kern_cred = prepare_kernel_cred(&init_task);
-	if (!kern_cred) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	old_cred = override_creds(kern_cred);
+	scoped_with_kernel_creds() {
+		ret = fw_get_filesystem_firmware(device, fw->priv, "", NULL);
 
-	ret = fw_get_filesystem_firmware(device, fw->priv, "", NULL);
-
-	/* Only full reads can support decompression, platform, and sysfs. */
-	if (!(opt_flags & FW_OPT_PARTIAL))
-		nondirect = true;
+		/* Only full reads can support decompression, platform, and sysfs. */
+		if (!(opt_flags & FW_OPT_PARTIAL))
+			nondirect = true;
 
 #ifdef CONFIG_FW_LOADER_COMPRESS_ZSTD
-	if (ret == -ENOENT && nondirect)
-		ret = fw_get_filesystem_firmware(device, fw->priv, ".zst",
-						 fw_decompress_zstd);
+		if (ret == -ENOENT && nondirect)
+			ret = fw_get_filesystem_firmware(device, fw->priv, ".zst",
+							 fw_decompress_zstd);
 #endif
 #ifdef CONFIG_FW_LOADER_COMPRESS_XZ
-	if (ret == -ENOENT && nondirect)
-		ret = fw_get_filesystem_firmware(device, fw->priv, ".xz",
-						 fw_decompress_xz);
+		if (ret == -ENOENT && nondirect)
+			ret = fw_get_filesystem_firmware(device, fw->priv, ".xz",
+							 fw_decompress_xz);
 #endif
-	if (ret == -ENOENT && nondirect)
-		ret = firmware_fallback_platform(fw->priv);
+		if (ret == -ENOENT && nondirect)
+			ret = firmware_fallback_platform(fw->priv);
 
-	if (ret) {
-		if (!(opt_flags & FW_OPT_NO_WARN))
-			dev_warn(device,
-				 "Direct firmware load for %s failed with error %d\n",
-				 name, ret);
-		if (nondirect)
-			ret = firmware_fallback_sysfs(fw, name, device,
-						      opt_flags, ret);
-	} else
-		ret = assign_fw(fw, device);
-
-	revert_creds(old_cred);
-	put_cred(kern_cred);
+		if (ret) {
+			if (!(opt_flags & FW_OPT_NO_WARN))
+				dev_warn(device,
+					 "Direct firmware load for %s failed with error %d\n",
+					 name, ret);
+			if (nondirect)
+				ret = firmware_fallback_sysfs(fw, name, device,
+							      opt_flags, ret);
+		} else {
+			ret = assign_fw(fw, device);
+		}
+	}
 
 out:
 	if (ret < 0) {

-- 
2.47.3


--bfhe7hunbxaimnt2
Content-Type: message/rfc822
Content-Disposition: attachment;
	filename="0004-nbd-don-t-copy-kernel-creds.eml"

From: Christian Brauner <brauner@kernel.org>
Date: Fri, 31 Oct 2025 16:37:39 +0100
Subject: [PATCH 4/6] nbd: don't copy kernel creds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-work-creds-init_cred-v1-4-cbf0400d6e0e@kernel.org>
References: <20251031-work-creds-init_cred-v1-0-cbf0400d6e0e@kernel.org>
In-Reply-To: <20251031-work-creds-init_cred-v1-0-cbf0400d6e0e@kernel.org>
To: Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=2100; i=brauner@kernel.org;
 h=from:subject:message-id; bh=COY45jn5H34HWUbvZYuyEV+h2VOPRcClNIvQycerb2E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSyXD/QeKHtfaOS0Opnc7l7lILml04oPebut0LoN8vyn
 f/4zp041FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRtdyMDE+OeHP8f848WUQw
 Yq/V/ODnfTXmUreOCx0IsnijeCa9gpGR4XH9dx19re9tNdbnKhT/bdtQIHI50HOL9jGBxfPLxN/
 o8gIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

No need to copy kernel credentials.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/block/nbd.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a853c65ac65d..1f0d89e21ec8 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -52,7 +52,6 @@
 static DEFINE_IDR(nbd_index_idr);
 static DEFINE_MUTEX(nbd_index_mutex);
 static struct workqueue_struct *nbd_del_wq;
-static struct cred *nbd_cred;
 static int nbd_total_devices = 0;
 
 struct nbd_sock {
@@ -555,7 +554,6 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 	int result;
 	struct msghdr msg = {} ;
 	unsigned int noreclaim_flag;
-	const struct cred *old_cred;
 
 	if (unlikely(!sock)) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
@@ -564,10 +562,10 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 		return -EINVAL;
 	}
 
-	old_cred = override_creds(nbd_cred);
-
 	msg.msg_iter = *iter;
 
+	with_kernel_creds();
+
 	noreclaim_flag = memalloc_noreclaim_save();
 	do {
 		sock->sk->sk_allocation = GFP_NOIO | __GFP_MEMALLOC;
@@ -590,8 +588,6 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 
-	revert_creds(old_cred);
-
 	return result;
 }
 
@@ -2683,15 +2679,7 @@ static int __init nbd_init(void)
 		return -ENOMEM;
 	}
 
-	nbd_cred = prepare_kernel_cred(&init_task);
-	if (!nbd_cred) {
-		destroy_workqueue(nbd_del_wq);
-		unregister_blkdev(NBD_MAJOR, "nbd");
-		return -ENOMEM;
-	}
-
 	if (genl_register_family(&nbd_genl_family)) {
-		put_cred(nbd_cred);
 		destroy_workqueue(nbd_del_wq);
 		unregister_blkdev(NBD_MAJOR, "nbd");
 		return -EINVAL;
@@ -2746,7 +2734,6 @@ static void __exit nbd_cleanup(void)
 	/* Also wait for nbd_dev_remove_work() completes */
 	destroy_workqueue(nbd_del_wq);
 
-	put_cred(nbd_cred);
 	idr_destroy(&nbd_index_idr);
 	unregister_blkdev(NBD_MAJOR, "nbd");
 }

-- 
2.47.3


--bfhe7hunbxaimnt2
Content-Type: message/rfc822
Content-Disposition: attachment;
	filename="0005-target-don-t-copy-kernel-creds.eml"

From: Christian Brauner <brauner@kernel.org>
Date: Fri, 31 Oct 2025 16:37:40 +0100
Subject: [PATCH 5/6] target: don't copy kernel creds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-work-creds-init_cred-v1-5-cbf0400d6e0e@kernel.org>
References: <20251031-work-creds-init_cred-v1-0-cbf0400d6e0e@kernel.org>
In-Reply-To: <20251031-work-creds-init_cred-v1-0-cbf0400d6e0e@kernel.org>
To: Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1284; i=brauner@kernel.org;
 h=from:subject:message-id; bh=K6xWUFfUpMJyCDaDqZ4RjsIipuOf60gf3GVeaKLlgG4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSyXD/gtdqvf/6zrHlxfJ+Erx5nSX6tUFlcLLmAmzsg6
 vAH2wUfO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbS0crw30no9YWZB6V2yGYv
 u3JWPqIy78HshXHHMkRnPT1yPl3v2yZGhtlOEs7z1r1Wsz5ZfG/Cv9WWjJyfZv6rNm41DZHZmGl
 7lQsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Get rid of all the boilerplate and tightly scope when the task runs with
kernel creds.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/target/target_core_configfs.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index b19acd662726..9e51c535ba8c 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -3670,8 +3670,6 @@ static int __init target_core_init_configfs(void)
 {
 	struct configfs_subsystem *subsys = &target_core_fabrics;
 	struct t10_alua_lu_gp *lu_gp;
-	struct cred *kern_cred;
-	const struct cred *old_cred;
 	int ret;
 
 	pr_debug("TARGET_CORE[0]: Loading Generic Kernel Storage"
@@ -3748,16 +3746,8 @@ static int __init target_core_init_configfs(void)
 	if (ret < 0)
 		goto out;
 
-	/* We use the kernel credentials to access the target directory */
-	kern_cred = prepare_kernel_cred(&init_task);
-	if (!kern_cred) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	old_cred = override_creds(kern_cred);
-	target_init_dbroot();
-	revert_creds(old_cred);
-	put_cred(kern_cred);
+	scoped_with_kernel_creds()
+		target_init_dbroot();
 
 	return 0;
 

-- 
2.47.3


--bfhe7hunbxaimnt2
Content-Type: message/rfc822
Content-Disposition: attachment; filename="0006-unix-don-t-copy-creds.eml"

From: Christian Brauner <brauner@kernel.org>
Date: Fri, 31 Oct 2025 16:37:41 +0100
Subject: [PATCH 6/6] unix: don't copy creds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-work-creds-init_cred-v1-6-cbf0400d6e0e@kernel.org>
References: <20251031-work-creds-init_cred-v1-0-cbf0400d6e0e@kernel.org>
In-Reply-To: <20251031-work-creds-init_cred-v1-0-cbf0400d6e0e@kernel.org>
To: Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CCxxWr9v95YYulbjM6F2nZgXs/Vl/C29zCuEFUeZyjM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSyXD9gbL/EMd/YvD1PfMlSl7z21UkpZX96hDbYKR4W6
 +kQlVLrKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmEifJCPD1w9Pjr9oYp5b39D0
 VE42/NbKz8+Nw56n5rCaiy2fUuHtxcgwxznMfs1uBY8gWXOF08pvjhdf9T5bbjr/VMXNpIfflJi
 5AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

No need to copy kernel credentials.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/unix/af_unix.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 768098dec231..68c94f49f7b5 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1210,25 +1210,16 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 	unix_mkname_bsd(sunaddr, addr_len);
 
 	if (flags & SOCK_COREDUMP) {
-		const struct cred *cred;
-		struct cred *kcred;
 		struct path root;
 
-		kcred = prepare_kernel_cred(&init_task);
-		if (!kcred) {
-			err = -ENOMEM;
-			goto fail;
-		}
-
 		task_lock(&init_task);
 		get_fs_root(init_task.fs, &root);
 		task_unlock(&init_task);
 
-		cred = override_creds(kcred);
-		err = vfs_path_lookup(root.dentry, root.mnt, sunaddr->sun_path,
-				      LOOKUP_BENEATH | LOOKUP_NO_SYMLINKS |
-				      LOOKUP_NO_MAGICLINKS, &path);
-		put_cred(revert_creds(cred));
+		scoped_with_kernel_creds()
+			err = vfs_path_lookup(root.dentry, root.mnt, sunaddr->sun_path,
+					      LOOKUP_BENEATH | LOOKUP_NO_SYMLINKS |
+					      LOOKUP_NO_MAGICLINKS, &path);
 		path_put(&root);
 		if (err)
 			goto fail;

-- 
2.47.3


--bfhe7hunbxaimnt2--
