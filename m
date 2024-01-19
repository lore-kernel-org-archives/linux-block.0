Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F07E1378
	for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 04:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705639687; cv=none; b=rQb+uGoWJVmw7wnNHu0clV5MRuyhVnjYji4qIRNRc4mfl9Z0Q9q/HL46qq7uJUwuTZ1/NE5sIT7QKAnXGIkWDHLUbIeCz1cfko3P51tjpKiQYo9XZboNSX7gfNn7OHq+rQjn8G0jTgOj36xvgIHxhM7OOqgkoYCblzbYqiH0MqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705639687; c=relaxed/simple;
	bh=2zMwRd++WGHO/dzFJ8oPHiUxD0AI5KxVbZ4Jm8rX+50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nm1on9m6AiNeDwVpRDLQvSe6vJUEXBFFmGvCCdkXyeRDG7dl2YE5cDMG5CXiaD8YmxkiYOq7cqFszOtia9eQy6+IEwLh+B41I8UGAJzFdfK1q7hNdG7hxleSVE9b89fuHZZc4pE4hxqD2ULv5rXScUn85xefVMMdiS8ZyPStiMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM89tsep; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM89tsep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2178BC433F1;
	Fri, 19 Jan 2024 04:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705639686;
	bh=2zMwRd++WGHO/dzFJ8oPHiUxD0AI5KxVbZ4Jm8rX+50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fM89tsepURNVeAZMjmdtYRyZjjLAd/QfOS3pzh/OnTAX7APvs+FEdqj+KWtmysfoh
	 AOpbM4gfq/nw5pcxS30EedesQ3Iat1omHxgzeHq3a25R6aKX203B/jLZKzB6KSXcY7
	 49m0qLHs9C8CEqPDAk0Y2wiRBRo7U6jLW89VGPl0DVT95qo6RJFHBIJYzKoHETrCQo
	 LsdI9tkLeZgmkA3Es31W+4C6V9yu8s2IsdH+b8qtTbfQcQl7H0D75YeUaJoPjrs9DT
	 fGHHLCSATDC0DgbzzoCHmym56Yqls7k9pO5sQ+mjHG0Rd7/NxRbyO748+00y/isRFe
	 5JhC39M15Db7A==
Date: Thu, 18 Jan 2024 21:48:03 -0700
From: Keith Busch <kbusch@kernel.org>
To: alan.adamson@oracle.com
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, linux-block@vger.kernel.org
Subject: Re: [RFC 0/1] nvme: Add NVMe LBA Fault Injection
Message-ID: <Zan_A-dR5ReYTfBF@kbusch-mbp.dhcp.thefacebook.com>
References: <20240116232728.3392996-1-alan.adamson@oracle.com>
 <20240118072419.GA21315@lst.de>
 <6874a81c-3f4f-428a-8a95-19898ca004a2@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6874a81c-3f4f-428a-8a95-19898ca004a2@oracle.com>

On Thu, Jan 18, 2024 at 09:02:43AM -0800, alan.adamson@oracle.com wrote:
> 
> On 1/17/24 11:24 PM, Christoph Hellwig wrote:
> > On Tue, Jan 16, 2024 at 03:27:27PM -0800, Alan Adamson wrote:
> > > It has been requested that the NVMe fault injector be able to inject faults when accessing
> > > specific Logical Block Addresses (LBA).
> > Curious, but who has requested this?  Because injecting errors really
> > isn't the drivers job.
> 
> 
> It's an application (database) that is requesting it for their error
> handling testing.

Going out on a limb here... This seems so obscure to burden a driver to
synthesize. Could we just give a hook for a bpf override and you can
totally go for whatever scenario you can imagine with a script?

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 50818dbcfa1ae..df87a63335aa8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -381,9 +381,22 @@ static inline void nvme_end_req_zoned(struct request *req)
 	}
 }
 
+#ifdef CONFIG_BPF_KPROBE_OVERRIDE
+static noinline blk_status_t nvme_req_status(struct nvme_request *req)
+{
+	return nvme_error_status(req->status);
+}
+ALLOW_ERROR_INJECTION(nvme_req_status, ERRNO);
+#else
+static inline blk_status_t nvme_req_status(struct nvme_request *req)
+{
+	return nvme_error_status(req->status);
+}
+#endif
+
 static inline void nvme_end_req(struct request *req)
 {
-	blk_status_t status = nvme_error_status(nvme_req(req)->status);
+	blk_status_t status = nvme_req_status(nvme_req(req));
 
 	if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET)))
 		nvme_log_error(req);
--
