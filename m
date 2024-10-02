Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB525366
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 00:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727827521; cv=none; b=nIpkV4eqdD2rAThMxdgBDf10nlUmQGE/1SOwxtWv71Ili5KTiXBcvva4hKOTN/b1vHn8QSR8LiWRNX7N0e4aXoRVO5rmWVil5G7ra+w1IdqQemKjaFFYiyWMkmRzcoSSRtQxcTc/BaO7n1URogHIfeG7ne3DpV2FQ5+6qrncE4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727827521; c=relaxed/simple;
	bh=/CV2L9JfJQt5E5RYpodw26MfQrUX+cJ+0L4O1Nm1koo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErWA8vXQ9dPCfukCuN2tnuPWXeOzOs5XlqC5G9rs1+mj3OH6JtSq+cp7ERc5OpPxYxkALvMvE3NWRY2MJuNuaVFWhyrcqjLn17TGHDg0mdE3OvDoaS0pD0cDTOdLOeBlx+2U99vseKQZbvT0vSHJ6auAq4YdqyYbXsBspdNh2tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxHsvEjX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxHsvEjX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3202FC4CEC6;
	Wed,  2 Oct 2024 00:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727827521;
	bh=/CV2L9JfJQt5E5RYpodw26MfQrUX+cJ+0L4O1Nm1koo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MxHsvEjX0UHwGRleWVXUGviwZRHhEFRmXUGiuX/6840Q/f7aMXAMFRlRp062vG06S
	 hYbQ8hbtIuBI4zcgKUCl+4ihyOAwcdVvjEzqFJfIstgMhZuhA+xLYNf7hy1AbOmRLG
	 6KLqARKjERPqpkWEYng+1IxC9kvdS1PDSMEcWAxo/fY2IpiwMWESiNGA8Lied2juYk
	 ulso43FO8Y3tcTk9LbJWiG6wRXLTrbGJedRPdYvUUaI6hG5zqYIVF72Lnww9FfM47c
	 PMPHh2VsoJcwmaG5m3UZhe3M8fR2dq/XrilhyM/k0rZUWbkvhs1Sq1hoskezvALyjT
	 DRygDiHxuOXBg==
Date: Tue, 1 Oct 2024 18:05:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: linux-block@vger.kernel.org
Subject: Re: subscribe
Message-ID: <ZvyOP-3v8gjMlcU2@kbusch-mbp.dhcp.thefacebook.com>
References: <CACzhbgRk9rzm0b6QdVdMZY-yk13nz+J9Uppt2pktQ3Hj4VBG1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACzhbgRk9rzm0b6QdVdMZY-yk13nz+J9Uppt2pktQ3Hj4VBG1g@mail.gmail.com>

On Tue, Oct 01, 2024 at 04:57:11PM -0700, Leah Rumancik wrote:
> subscribe

Thank you for your interest, but I think you meant to send:

  subscribe linux-block

To majordomo@vger.kernel.org instead.
