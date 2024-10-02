Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56FD1FDA;
	Wed,  2 Oct 2024 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727850652; cv=none; b=k8/ux0cnTywe1no7vfYtXWJtpe41CBrClxspVEAgR3xnMdzh4YVCPosqfQhMBIfEmfJZ6PjRijit16cxFqp/JV2ySfgr6N6DCVuufCMJvuLHIL3BwF0wqK8J9d/HPLLgCYy5hMgQOvDxGgxCZMQuMhnuYzEiAkT3mNlylRpRzYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727850652; c=relaxed/simple;
	bh=gP0sKfhvuSzg57TNF4iZB6rcl55U6xG8gnT83uX1NM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GciiG+cYqjFT59oU7PUaLYuDtOrhaOYAWINDg7cbPXM9E1KYNs9eFjKG9TOvPKhKSt9bAEC56P2+AOeQjXp7eFci6YPniX/CrIXKQwqP6AGHd53XWnctal7zuX4k1gzZKahI2MCvAKbY1RUciYyTIENAf3NL4Gs0Awdt1jb8QLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SVt5Wfe+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SVt5Wfe+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2439C4CEC5;
	Wed,  2 Oct 2024 06:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727850652;
	bh=gP0sKfhvuSzg57TNF4iZB6rcl55U6xG8gnT83uX1NM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SVt5Wfe+ixxQYeEvzIHoQluwKBk7pJq4X/hDB34WhI9RH1E+aTExMoNWIG17fiqXn
	 lfhAkLnG2N7ZsrYNcXgMlCPfMWEP0h9IDhNZ5GyV1mJc0BEyUkSeI+vC0dXh6fX7vw
	 axrFXlnZ8brcTN+SXS+8BBsQRzzOdYD7IGRl9Khs=
Date: Wed, 2 Oct 2024 08:30:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chun-Yi Lee <joeyli.kernel@gmail.com>
Cc: Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	Nicolai Stange <nstange@suse.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chun-Yi Lee <jlee@suse.com>
Subject: Re: [RFC PATCH 2/2] aoe: using wrappers instead of dev_hold/dev_put
 for tracking the references of net_device in aoeif
Message-ID: <2024100223-selection-thirsty-99b9@gregkh>
References: <20241002040616.25193-1-jlee@suse.com>
 <20241002040616.25193-3-jlee@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002040616.25193-3-jlee@suse.com>

On Wed, Oct 02, 2024 at 12:06:16PM +0800, Chun-Yi Lee wrote:
> Signed-off-by: Chun-Yi Lee <jlee@suse.com>

For obvious reasons, we can't take patches without any changelog
comments, nor really review them either :(

thanks,

greg k-h
