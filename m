Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FF429CEB;
	Fri, 23 Aug 2024 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418147; cv=none; b=QH6s3dMgI8YmX5yqZLQIlqezvrY8MwyaH+GmgzhShCFSQ1gcZIRG9YVa113h4AVkKhIbsuMSrNDUlf/WZTFtibDjMwLwvR93/FJQMoz0v9s/U3i2jEnV44AMhql1JwVCdeIq1y5i99IMET/dEyHFR84REW3iKjA7In6smzgYEwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418147; c=relaxed/simple;
	bh=QIyJgxkRV2MDD4htjgdRDrYdt5c+wGSIiqCsbfy9egk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgzjHxKwfPHAvY3h5DrTUHBIExwQG157gmTXXEXJpMQ3LbxbFiM0zzlqEd/AZIpH9hmERrDP9ym9C3UL34yCcQqjMm58WJ9+sKY/j8zvNMxs4bXYvVqMhofYq/4usif1ceazkSzyXtv98s6dfo+zwKfQk/moPNIbYxCFoHCOoWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0bBRbPSj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0bBRbPSj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E50BC32786;
	Fri, 23 Aug 2024 13:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724418146;
	bh=QIyJgxkRV2MDD4htjgdRDrYdt5c+wGSIiqCsbfy9egk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0bBRbPSjLZD6Q0SYKzQImqhJlgyfSMnNk/QcNJS57jpn5si284p0f4ug8Xr8J9nyP
	 3QLYcVxUpCu8KvsTiHDt+vGh6/5EISqCQAx6zolorHsvT32yx+LAqPhIRXUxe7aci9
	 NcTPum3yOf5k/cE9DVjoZAkxUQ3giBGi89Yzzpj4=
Date: Fri, 23 Aug 2024 21:02:23 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yang Ruibin <11162571@vivo.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v4] drivers:block:Cancel debugfs_create_dir() check
Message-ID: <2024082346-delivery-oblong-cd4c@gregkh>
References: <20240823112246.3905118-1-11162571@vivo.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823112246.3905118-1-11162571@vivo.com>

On Fri, Aug 23, 2024 at 07:22:45PM +0800, Yang Ruibin wrote:
> No need to check debugfs_create_dir() return value.
> It's safe to pass in errors that debugfs_create_dir() gives you.
> 
> Fixes: f40eb99897af ("pktcdvd: remove driver.")

It's not a "fix", it's just a cleanup.  The current code just never
actually triggers so it's not like there is any functional change here
at all.

thanks,

greg k-h
