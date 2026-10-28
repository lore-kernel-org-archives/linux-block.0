Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217123;
	b=0+iJnSfHmUNhJo+xZPEB8wIoidf1IiVAzgInuOrphhtp99YqT9seEuuyR87lgLFqHuLt
	 hkhwHqor/hBOZ2Q2Z1zrcDqgbBl5VBw1IBz2fe+uut/IqxjglX15TClvhNxtTljFbTMvp
	 kz469ocpfWiDv9OcucgTfsBahm8/2FUEobsGE2qAlehfrkMVPrgrHW32BSFAwpkeo865D
	 RJgsmKqQDL0fwZhDe3YN1zDY3K1+8MSQ7XDgaMfGvsOICMiNSj2hq/Z5Mjj7pLq7BW4w0
	 b053o8+HqVauGjKkX/FyOgE2jAzuyv/zChFuOl3A3qVf6blfEf2G0q0jtPZJWvUF/1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217123;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/X88G6+jvmG3sSneE0AaMx8t3SJ+XPZbr8IMvKX2v48=;
	b=CSLQ3Umxd2mhAwu/2ZETPWoaVXeHqjZyMrfLPM+G9YvompB0dx2bvBMh63wWjM7Nv1eP
	 lDP1mDZfzM8f/nMpATSvMNMjhABjgBoWPVgfo1mrWBL1UNjB3mfA2b+t8TMoeCRS8UMeV
	 1C8MXh5zpcOPrTyIkrXvU/YgKjcIb8E1r9xuTsNu8GZUwA9pQxzJK4wThISyxS5emTIVh
	 3FOfRbBel14qBEhoBsAbcUVQgj0zOi5hq0XCWnElci63JxcQivCf2vG+FH47oJNOou9/J
	 JtCYfj2QoqZRI5S6QwkQY8OcTPQA5SBp3KGFX0aLIWu8QK/YTcOrZBzj/16z+kNw31Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARQtz30V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A78606A31F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARQtz30V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B971F031E1;
	Wed, 28 Oct 2026 19:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793217122;
	bh=/X88G6+jvmG3sSneE0AaMx8t3SJ+XPZbr8IMvKX2v48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ARQtz30VL2Cc/9dm5Mpe6ww0YLrzSOwAK/L3Yveo75dl1LiGyNlm7tIfzN1R1Zokc
	 YPvOronGCt0/b9CaXHpFGjgQUfd/+hSNGsRbiJNNdMYF8fKO2uMBPZXOG08jxOTtZ+
	 43kANee6026A+qpMivgegOVAigxljnCUYYVEE8XOvsJZsHvrh/D6PKwWoy/tEzbm5K
	 WhbKDw+5G+3gam44P/FgL86iyNQ3VjBvdvP5ouJAy+GDM57RF51Kv0QjjukzSVyJ+r
	 oSScg7P37uciAJCAHaB5nfO0ve8gk6lmav7q25CKo7Qq28GAqEkLMCVSWeUzVRhciA
	 Hd76v+XHbYsww==
Date: Wed, 28 Oct 2026 13:52:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCHSET 0/98] Various block related fixes
Message-ID: <auJSYF4iz0EXquwp@kbusch-mbp>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <c16356fc-662e-4939-ad76-355f3a62ed4c@acm.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c16356fc-662e-4939-ad76-355f3a62ed4c@acm.org>

On Wed, Oct 28, 2026 at 12:22:53PM -0700, Bart Van Assche wrote:
> On 10/28/26 9:41 AM, Jens Axboe wrote:
> > Got a giant pile of stuff dumped on me, and went through and did some
> > vetting and, particularly, commit message rewriting to get it to a
> > somewhat comprehensible shape. If you're CC'ed on a patch, please
> > review it. Feel free to queue it up, or reply back why the particular
> > patch is garbage, if it is garbage.
> 
> Hi Jens,
> 
> Reviewing 98 patches at once is too much for a human. So I asked an LLM
> to take a look. That LLM identified 9 must fix issues and 15 minor
> issues. Please take a look at the attached report.

Thanks, Bart.

Your review flagged a couple patches I had already queued up, so let me
explain why I think it's safe to proceed with them.

> ### 1.4 Patch 90/98 - `nvmet-rdma: disable interrupts under rsp_wr_wait_lock` (Executes `req.execute()` & `mutex_lock()` in HardIRQ/SoftIRQ Context)
> - **Patch**: [90/98](https://lore.kernel.org/linux-block/20261028164415.1262013-91-axboe@kernel.dk/) (Chris Mason) - [`nvmet_rdma_process_wr_wait_list()`](file:///usr/local/google/home/bvanassche/software/linux-kernel/drivers/nvme/target/rdma.c#L514-L537) in [rdma.c](file:///usr/local/google/home/bvanassche/software/linux-kernel/drivers/nvme/target/rdma.c#L514-L537)
> - **Root-Cause Diagnosis**: Valid. `nvmet_bio_done()` -> `nvmet_req_complete()` -> [`nvmet_rdma_queue_response()`](file:///usr/local/google/home/bvanassche/software/linux-kernel/drivers/nvme/target/rdma.c#L717-L752) can run in hardirq or softirq context; when `ib_post_send()` fails, `nvmet_rdma_release_rsp()` calls `nvmet_rdma_process_wr_wait_list()`, which previously took `rsp_wr_wait_lock` with plain `spin_lock()`.
> - **Why the Fix Is Incomplete**: As the commit message itself notes, `nvmet_rdma_process_wr_wait_list()` drops `rsp_wr_wait_lock` (restoring the caller's hardirq/softirq state) and calls `nvmet_rdma_execute_command(rsp)` -> `rsp->req.execute(&rsp->req)` **directly in hardirq/softirq context**! Almost every `nvmet` `req.execute` handler assumes process context:
>   - `nvmet_bdev_execute_rw()` calls `bio_alloc(..., GFP_KERNEL)` and `submit_bio()` -> `submit_bio_noacct()`, which hits `might_sleep()` and manipulates `current->bio_list` without interrupt protection (corrupting any interrupted task's `current->bio_list`!).
>   - Admin/fabrics/auth/PR handlers (`nvmet_execute_identify_*`, `nvmet_execute_admin_connect`, `nvmet_execute_auth_*`, `nvmet_execute_pr_*`) call `kzalloc(..., GFP_KERNEL)`, `mutex_lock()`, and `down_read()`.
>   - Furthermore, if **Patch 69** is applied and `ib_post_send()` fails on a dying queue in hardirq/softirq context (`nvmet_rdma_queue_response()` doesn't currently call `nvmet_rdma_error_comp()`, though `nvmet_rdma_Disconnect` paths take `mutex_lock(&nvmet_rdma_queue_mutex)`), any fatal error path assuming process context will sleep in atomic.
> - **Suggested Fix**: Offload `nvmet_rdma_process_wr_wait_list()` to a `work_struct` on `nvmet_wq` (or queue the work whenever `!in_task()`) instead of calling `nvmet_rdma_execute_command()` in interrupt context.

I agree the wait list shouldn't run from the completion context, but
that issue predates this patch which only fixes the lock inversion that
lockdep found. Patch seems a safe improvement to proceed with.

> ### 1.8 Patch 76/98 - `nvmet: fix NULL dereference in debugfs host_traddr` (Unlocked TOCTOU NULL-Deref & UAF Remains)
> - **Patch**: [76/98](https://lore.kernel.org/linux-block/20261028164415.1262013-77-axboe@kernel.dk/) (Josef Bacik) - [`nvmet_ctrl_host_traddr()`](file:///usr/local/google/home/bvanassche/software/linux-kernel/drivers/nvme/target/core.c#L1822-L1830) in [core.c](file:///usr/local/google/home/bvanassche/software/linux-kernel/drivers/nvme/target/core.c#L1822-L1830)
> - **Root-Cause Diagnosis**: Valid. When the admin queue (`ctrl->sqs[0]`) disconnects while I/O queues remain open, `nvmet_sq_destroy()` sets `ctrl->sqs[0] = NULL`, so reading `host_traddr` in debugfs crashes with a near-NULL dereference (`container_of(ctrl->sqs[0], ...)`).
> - **Incomplete Synchronization**: As the commit message candidly admits (*"Nothing holds the queue for debugfs, so a reader that's past the check when the queue goes away is still on its own"*), `if (!ctrl->sqs[0])` is a plain unlocked load, and `nvmet_tcp_host_port_addr()` / `nvmet_rdma_host_port_addr()` / `nvmet_fc_host_traddr()` immediately perform a second unlocked load of `ctrl->sqs[0]` and dereference the transport queue (`queue->sockaddr_peer`, `nvme_rdma_cm_id`, `assoc->hostport`) concurrently with `nvmet_sq_destroy()` freeing the queue (`kfree(queue)` -> **TOCTOU NULL deref and KASAN UAF**).
> - **Suggested Fix**: Snapshot the formatted `host_traddr` string into a small `char host_traddr[NVMF_TRADDR_SIZE]` buffer in `struct nvmet_ctrl` during admin queue `Connect` (`nvmet_alloc_ctrl()` / `install_queue`), and have `nvmet_ctrl_host_traddr()` copy that immutable buffer. That eliminates all transport queue lifetime races with ~4 lines of code.

Yeah, this fixes the deterministic crash, but a reader can still get
past the check and race the teardown into the transport callback. I
don't think a snapshot is needed though: the controller is being torn
down, so showing a stale address isn't useful, and returning an error
is fine.

Clearing ctrl->sqs[qid] under ctrl->lock in nvmet_sq_destroy() and
holding it across the check and the ->host_traddr() call should close
the race. Guixin is working on the same race for the tls_key attribute,
so it'd make sense to fix both the same way.
