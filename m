Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903B41F4262;
	Thu,  4 Sep 2025 02:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756953381; cv=none; b=eMcDw3gWazXkotq33CHG9t+/Tk/9NCvehRR1vUDRItLE4bH7VPpt7I/ITyDgWuemCHXZxL0RwyU3nGDU90bftYMstlSu2XVsabsv8++w7G3ADUzpJNfjaOC6y9ULctq9WFueLWpzInNXShpdWkATfiO40jGK21uhH3C9dthkR6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756953381; c=relaxed/simple;
	bh=OCrUYJXkvkyovxowtckM4Zja0dS+w8lV4H+Wl8gjzdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XxAMoiwGeWasd4HoTQy8Gl+/I0UsUkhmHsh/PhUd3zpvUywgpQGdwMW6s1QRZYuRZfc4lWlrXGwH1N2hmvcF0Y0reWBocwdAYW2S+etacP35DeBfenfa4o/e7S6jAOAkRTD+eJukqKGKJ2LCoezgmz0pludU5TipnSqtLvRlnHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsWMoWjO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsWMoWjO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC99C4CEE7;
	Thu,  4 Sep 2025 02:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756953380;
	bh=OCrUYJXkvkyovxowtckM4Zja0dS+w8lV4H+Wl8gjzdA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=QsWMoWjObXNYZ+GbfeWR45l2yqhnSRs1fCo9DGb1mZ0qaw5iTly6pKjcJ3aMYuRQm
	 umfIzx4kKJjZzX3SJPbviduvrPa7ejKRzIYCxiid28UiADkRHOFw/cB+i0Ye00O0fP
	 zf4aTTKcYEb6oncgS9fAibGfwq5FgKk+nqsa3ueLxznwQWMQHBNntBSt2lnUe0aK/R
	 Jg/xdfmpf609GgCCIOQkhUXCqSGIuHYIc801l/tU+zwEwsisXtX38+uL03ChkTp7Ul
	 d0iGg/2XEu6P40nXFil3jrgq4vek3wG/Bqed4uZ3pzEpbvOWJMjmqmtAlBZJzfiagn
	 gYPq8IZCcncaQ==
Message-ID: <b0c67c9a-d364-4840-8e76-cdfc66889ac2@kernel.org>
Date: Thu, 4 Sep 2025 11:33:20 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] elevator: avoid redundant conditions
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Jens Axboe <axboe@kernel.dk>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250903121405.386483-1-liaoyuanhong@vivo.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250903121405.386483-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/25 9:14 PM, Liao Yuanhong wrote:
> While 'if (i < 0) ... else if (i >= 0) ...' is technically equivalent to
> 'if (i < 0) ... else ...', the latter is vastly easier to read because
> it avoids writing out a condition that is unnecessary. Let's drop such
> unnecessary conditions.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
