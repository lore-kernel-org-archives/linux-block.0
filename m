Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2621330FC25;
	Tue, 18 Nov 2025 03:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763435951; cv=none; b=Bq5VBsEn9XxBX0y6emlcxXGgTuinJ7UbNA58oxW457CqjBWi6WzAajRnh/dlp2w0xyBJF1Z5Jj0XUFAE2NPhMSzL0WJgIZEEuWlgNbmnEddepBRhNcB26jC4kqK5RvW3kiNngU/aWGWrppmoRBfkW2UQ3PoWSulhmkp5t4V0q/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763435951; c=relaxed/simple;
	bh=9UFZ0P1qE7Lt0pbbX0a4vQMfaASP+tmGNxWlPK0M8d8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=m5bmf0Ha98xiU3jxeBqMReciTJQSuLco4u8M6q47VW1b/PlGevpZtyIBBn7+EYZPBU8AnDXnD0LUwT4gdvnKLwWTqMMZfa6zmIFnHiHs3m4y81Qkq1JeLNFM1YiYqv0lg9HAR0+rbUj7/ygX3pRZ2sa4Q5l4pFvYfuo7fB41ROk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Bkl9jlVe; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Bkl9jlVe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1763435939;
	bh=jn2tYAr/EHfM0hmtO9W5VlUn1ZQ1mGdkQfHiF3xGSKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bkl9jlVeKdYI9eoOrlOfaZk9tih2w5sT2uJaAMYdTx3EAIbg5+oqVlcmUlQk6/f0r
	 egPBODPeWRG5TSO0dPQeN60IuTt/n55xJ2b05W6zBBQkF6nuPZBuSKkHmTVeUCO8zj
	 o2CrbRNu5rO0jSXGVlSzG3XcfT00LVK/0hIFh604=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 4B8BC81D; Tue, 18 Nov 2025 11:18:56 +0800
X-QQ-mid: xmsmtpt1763435936tgfvowgug
Message-ID: <tencent_295C252FFDABBAEBA3088D5B72DCDE15EB05@qq.com>
X-QQ-XMAILINFO: MZtEYADUG4AgfdWAQf+qZ54lVhebfHhdDMGqPAgwFiuq0THzTSkCBhdmMX+SzQ
	 1SMlm3v0OKFNJFAywHUKrnww5srPjcJKEuNPl5ssQDpyPwRFYQFAyNWb+Hi2s8m8/upmOCtNGZWo
	 MYFdkvoPZll66ZQWSoxSdb1MKDUN1Qb7u5ekc6t0/bA/151Hzwn4FDtNAgHCTRqn7h17cTuNm6/d
	 aGQgL5VFUhc3+Nak/vIhzxIsrf6t7Ben2Bbzo3rqbjn6SC3/DyXyYgKLcsrb0iBmfa74TcMgQNUd
	 JDIdSJyymmnksCOl2o+PVXLzbQJFZFW0rjI9n0fmD8zmO/E5dUTveZNx7sFl2hvKPNx+3Fjkoxja
	 F7Oy5ud5aJpm/2ImpuNF9Ugl3MzRinRokeL3t7Ciw1Ie9Ki2QjilnsI82UOLogfxGQbSTKL1oDZR
	 aqy26wiEF0aJJiw92pCiysZs7lVadk7dxhZPk5uXmlLYegvO1R0Ku7yr0UtjWKDbTqG+5nQ+vDHE
	 Uo4bq3PepD28JYo0GimguFkNK6GqbZxZoGO9mNpmExkqm2xjjveRPjoVfrHmtMtnQv2KUxk3gACx
	 C/x1DQZP2PoJ+M5B/qmb5X+WPjJBdg6o5C5+RXR1jpViwwS30oRO46bNk2TbuedQ74XSAw96oQQB
	 w5jlrwlF8kziX3U3O6vd8RA/zqZoiToME5olPsKSlceYPpSvpE/QJZo+6B9MXgYKXFBroZ0CkWFs
	 3BTyKG2kCy0fAf2g69unnmGYoOrryIeWUZR7IHIqwKOLfK4+DdgOn01JpEb8H+FTU0UvURTp568+
	 KnUah8O+bw0dEvVczYY+oDlD067lJtAWTgfrnjNsQiIoIcNWh0M6S1US68rMv9l4YPzQMgRXEXBy
	 Uoa2krF+hrMVlLlCCDjjBKr5Y/tkUfhSx1wPDaQH52XUGqm+XlweLMrxmnpVlo+pP844URwp4p9G
	 MILv8NTKReA9a7vz7A8huLjGzCwiPEXYc3mW0gvAHX8/azugwb+Tgi/FqOESEyOSUIq/xf2BncZ9
	 9m26ENYI0ZrIB4E7YdytTSiU45cwzzzu1zZH3uLOpfuJPaSMgHjG9+f4If712p8XqGEJDF6w==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: senozhatsky@chromium.org
Cc: akpm@linux-foundation.org,
	bgeffon@google.com,
	licayy@outlook.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@google.com,
	minchan@kernel.org,
	richardycc@google.com,
	ywen.chen@foxmail.com
Subject: Re: [PATCHv3 1/4] zram: introduce writeback bio batching support
Date: Tue, 18 Nov 2025 11:18:56 +0800
X-OQ-MSGID: <20251118031856.2800796-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3nqzi2v72dsef2dte7iqe7wahrbzam33druh7klsh45zvefdm3@ab6stznzdxmh>
References: <3nqzi2v72dsef2dte7iqe7wahrbzam33druh7klsh45zvefdm3@ab6stznzdxmh>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 17 Nov 2025 10:19:22 -0500, Sergey Senozhatsky wrote:
> +static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
> +{
> +	u32 index;
> +	int err;
> +
> +	index = req->pps->index;
> +	release_pp_slot(zram, req->pps);
> +	req->pps = NULL;
> +
> +	err = blk_status_to_errno(req->bio.bi_status);
> +	if (err) {
> +		/*
> +		 * Failed wb requests should not be accounted in wb_limit
> +		 * (if enabled).
> +		 */
> +		zram_account_writeback_rollback(zram);
In this place, the index may be leaked.

> +		return err;
> +	}
> +
> +	atomic64_inc(&zram->stats.bd_writes);
> +	zram_slot_lock(zram, index);
> +	/*
> +	 * We release slot lock during writeback so slot can change under us:
> +	 * slot_free() or slot_free() and zram_write_page(). In both cases
> +	 * slot loses ZRAM_PP_SLOT flag. No concurrent post-processing can
> +	 * set ZRAM_PP_SLOT on such slots until current post-processing
> +	 * finishes.
> +	 */
> +	if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
> +		goto out;
In this place, the index may be leaked.

> +
> +	zram_free_page(zram, index);
> +	zram_set_flag(zram, index, ZRAM_WB);
> +	zram_set_handle(zram, index, req->blk_idx);
> +	atomic64_inc(&zram->stats.pages_stored);
> +
> +out:
> +	zram_slot_unlock(zram, index);
> +	return 0;
> +}

