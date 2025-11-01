Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564BD19ABC6;
	Sat,  1 Nov 2025 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762004014; cv=none; b=Nbg8pi247SZLg6gVHNvz1yNeeMmGzd5ME86G0epIOcNuBqUt65s6RfBHqwt9Bxx+x8Ge/UbMSBnCFMnKkjwHUNfdV9qhu9+cdfXi/whvH/NBaNZ6PaAabp1wH34CJaEznRiG9TgjZsUSNBKxgtUkSepBSYB+An/NV0KOWyxd7/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762004014; c=relaxed/simple;
	bh=TQAu2LgY/k05+z8WPE3OEpCJHZt9JLQO2WzYvSg262Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrdOzie/ZHZb4qJ4G16MjbZqvBSvUG5PRhq6h4Y+iy5x7+TQW3lFhQtGcqRe07x2lc2UY5nwy2YFsQetjz3ouI0mtZ2A79ayJRPOCP9Spkx6R3KuPPUy9WmdRILVak+TB5kInAbxWY3WEiQhM0INb4hqW50K1jYYAoG8+ge0WGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRp064vO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRp064vO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68774C4CEF1;
	Sat,  1 Nov 2025 13:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762004013;
	bh=TQAu2LgY/k05+z8WPE3OEpCJHZt9JLQO2WzYvSg262Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PRp064vOwtJHbK7bKUW015qiAZQNinv8mRZB6G74KQO3VQ+sKS00hehgtJ3BKi2bS
	 /yN6m3EBGY2CVsBL5z563DEmd2rrDJGQrHZxfy7So+PRq8tL8Hm3jPt3nsm3BFmlAJ
	 hJGAtmMUZbSld3X9EEiO5UViVX9/RdJHQdBD+yABolgkC5fOblk0fmfs70NhqdZJmF
	 fe88yMmNKERnI+EiSBU8/g8uaBpqL+Guf0MvjVSicu4+IgZmWcg/KeJ9la5+sUwzEP
	 4PpG7fFHIrXefLkIWTQuDOgfBB+fzb+woo/y0I0eVNwLTEm9HoIK7eJh7Tg9+hweKZ
	 uuwWAmCl47xfw==
Date: Sat, 1 Nov 2025 14:33:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [GIT PULL] Block fixes for 6.18-rc3
Message-ID: <20251101-unrecht-zugibt-18edd09b7418@brauner>
References: <37fb8720-bee9-43b7-b0ff-0214a8ad33a2@kernel.dk>
 <CAHk-=wgZ9x+yxUB9sjete2s9KBiHnPm2+rcwiWNXhx-rpcKxcw@mail.gmail.com>
 <20251031-zerkratzen-privileg-77a7fb326e34@brauner>
 <CAHk-=wg6+ngpnQsp0ic_5Ebhv5g=cVKVWjrJyRBQWBp4MDiJNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg6+ngpnQsp0ic_5Ebhv5g=cVKVWjrJyRBQWBp4MDiJNQ@mail.gmail.com>

On Fri, Oct 31, 2025 at 09:30:11AM -0700, Linus Torvalds wrote:
> On Fri, 31 Oct 2025 at 08:44, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Hm, two immediate observations before I go off and write the series.
> >
> > (1) The thing is that init_cred would have to be exposed to modules via
> >     EXPORT_SYMBOL() for this to work. It would be easier to just force
> >     the use of init_task->cred instead.
> 
> Yea, I guess we already export that.
> 
> >     That pointer deref won't matter in the face of the allocations and
> >     refcounts we wipe out with this. Then we should also move init_cred
> >     to init/init_task.c and make it static const. Nobody really needs it
> >     currently.
> 
> Well, I did the "does it compile ok" with it marked as 'const', but as
> mentioned, those 'struct cred' instances aren't *really* const, they
> are only pseudo-const things in that they are *marked* const so that
> nobody modifies them by mistake, but then the ref-counting will cast
> the constness away in order to update references.
> 
> So I don't think we can *actually* mark it "static const", because
> that will put the data structure in the const data section, and then
> the refcounting will trigger kernel page faults.
> 
> End result: I think we can indeed move it to init/init_task.c. And
> yes, we can and should make it static to that file, but not plain
> 'const'.
> 
> If we expose it to others - but I think you're right that maybe it's
> not a good idea - we should *expose* it as a 'const' data structure.
> 
> But we should probably put it in some explicitly writable section (I
> was going to suggest marking it "__read_mostly", but it turns out some
> architectures #define that to be empty, so a "const __read_mosyly"
> data structure could still end up in a read-only section).

For some init data structures that are heavily used such as:

init_pid_ns

it often makes sense to just skip the refcounting completely because we
know they are always around. Take the pid namespace as an example:

static inline struct pid_namespace *get_pid_ns(struct pid_namespace *ns)
{
	if (ns != &init_pid_ns)
		ns_ref_inc(ns);
	return ns;
}

void put_pid_ns(struct pid_namespace *ns)
{
	if (ns && ns != &init_pid_ns && ns_ref_put(ns))
		schedule_work(&ns->work);
}

While it has the obvious disadvantage that it introduces a special-case
into the refcounting and it would obviously be more elegant if we just
did:

void put_pid_ns(struct pid_namespace *ns)
{
	if (ns_ref_put(ns))
		schedule_work(&ns->work);
}

it does elide a ton of refcount increments and decrements during task
creation.

While that's not true for init_creds it would still be easy to just not
refcount them at all if it's worth it.

Now that I think about it: given that I reworked all the namespace
reference counting completely it should be easy to make all initial
namespaces not get or put reference counts at all, like:

static __always_inline bool is_initial_namespace(struct ns_common *ns)
{
	VFS_WARN_ON_ONCE(ns->ns_id == 0);
	/* initial namespaces have fixed ids and the ids aren't recycled */
	return ns->ns_id <= NS_LAST_INIT_ID;
}

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 241eb1e98e1d..fe9c81963786 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -136,9 +136,8 @@ struct ns_common *__must_check ns_owner(struct ns_common *ns);

 #define to_ns_common(__ns)                                    \
@@ -225,6 +224,8 @@ static __always_inline __must_check int __ns_ref_active_read(const struct ns_com

 static __always_inline __must_check bool __ns_ref_put(struct ns_common *ns)
 {
+       if (is_initial_namespace(ns))
+               return false;
        if (refcount_dec_and_test(&ns->__ns_ref)) {
                VFS_WARN_ON_ONCE(__ns_ref_active_read(ns));
                return true;
@@ -234,6 +235,8 @@ static __always_inline __must_check bool __ns_ref_put(struct ns_common *ns)

 static __always_inline __must_check bool __ns_ref_get(struct ns_common *ns)
 {
+       if (is_initial_namespace(ns))
+               return true;
        if (refcount_inc_not_zero(&ns->__ns_ref))
                return true;
        VFS_WARN_ON_ONCE(__ns_ref_active_read(ns));
@@ -246,7 +249,8 @@ static __always_inline __must_check int __ns_ref_read(const struct ns_common *ns
 }

 #define ns_ref_read(__ns) __ns_ref_read(to_ns_common((__ns)))
-#define ns_ref_inc(__ns) refcount_inc(&to_ns_common((__ns))->__ns_ref)
+#define ns_ref_inc(__ns) \
+       do { if (!is_initial_namespace(to_ns_common(__ns))) refcount_inc(&to_ns_common((__ns))->__ns_ref); } while (0)
 #define ns_ref_get(__ns) __ns_ref_get(to_ns_common((__ns)))
 #define ns_ref_put(__ns) __ns_ref_put(to_ns_common((__ns)))
 #define ns_ref_put_and_lock(__ns, __lock) \

This effectively means we can drop all the special-casing in the
namespace helpers like:

diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 445517a72ad0..ef06c3d3fb52 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -61,9 +61,7 @@ static inline struct pid_namespace *to_pid_ns(struct ns_common *ns)

 static inline struct pid_namespace *get_pid_ns(struct pid_namespace *ns)
 {
-       if (ns != &init_pid_ns)
-               ns_ref_inc(ns);
-       return ns;
+       ns_ref_inc(ns);
 }

 #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 650be58d8d18..e48f5de41361 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -184,7 +184,7 @@ struct pid_namespace *copy_pid_ns(u64 flags,

 void put_pid_ns(struct pid_namespace *ns)
 {
-       if (ns && ns != &init_pid_ns && ns_ref_put(ns))
+       if (ns && ns_ref_put(ns))
                schedule_work(&ns->work);
 }
 EXPORT_SYMBOL_GPL(put_pid_ns);

And all the other ones - without having looked into any potential
pitfalls - would get the same behavior as the pidns for free. Worth it?

I think especially for the network namespace that might potentially
avoid a bunch of cacheline ping-pong. But idk, it's just a theory. But
it's easy enough to implement.

> 
> > (2) I think the plain override_creds() would work but we can do better.
> >     I envision we can leverage CLASS() to completely hide any access to
> >     init_cred and force a scope with kernel creds.
> 
> Ack.
> 
>                   Linus
