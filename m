Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F1E55887;
	Fri, 20 Sep 2024 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726830246; cv=none; b=GKBJQS8axHZ589C1VTPDpn7IrzSMaHS7Hdgb3RCuAJ0shIo/LXMIV1ubOR8cldqS5U1r4rCVkrolDWOZqVbN+E13nr64JvXku9FU4IMvNd77kJP5rRr2ps0bwzQo1GsB7Vm+BEJuWJotAp5rbKmt9ZKXtqH+McmsLVFmLIVrBXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726830246; c=relaxed/simple;
	bh=00KpENy9RAHDQ6vIrsWKsLWRzDD2uX+wnmARMq1n1aE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lntPG8W9cOLOMot07sLH3YXJ9YtkddXSkktvzLH+IRXQJOV4zREIw4PLJ7cn5KzfnuuF2vImOAtKqcEhXKcJIJDxbhXO5ot++1MwUtScpP5Nd8R6BwtrseIxhc3ZGgUTJgZASxySrmFMUd4lX+XdKFaSC904/QnDS6U/oYRp2ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g1QQUt1z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g1QQUt1z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E5CC4CEC6;
	Fri, 20 Sep 2024 11:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726830245;
	bh=00KpENy9RAHDQ6vIrsWKsLWRzDD2uX+wnmARMq1n1aE=;
	h=From:Subject:Date:To:Cc:From;
	b=g1QQUt1zjeZQEPsAV6agqC9wB1FLcEC6UwKOHMgbl3vetjfn/jx+9mKP+PlrUjEai
	 uANRNMZKJCH4PHSBT0jWK+nfKZqFSuK1aUlalCKz9CGlnX6MydJySOFxG/LmwzKp0l
	 sNViqCFwczjY1SkCLxgu3DCwnDtfeptuEo9yeU+Q=
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: [PATCH 0/2] MAINTAINERS: ensure that mailing lists are L: not M:
Date: Fri, 20 Sep 2024 07:03:25 -0400
Message-Id: <20240920-maintainers-m-to-l-tweak-v1-0-ea80b5cd3420@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH1W7WYC/x2MQQqAIBAAvxJ7bsEsCftKdBDbaqksVCqQ/p50m
 MMcZhIE8kwBuiKBp4sDHy5LVRZgF+NmQh6zgxSyEbrSuBt2MUM+4I7xwA3jTWZFo6RWVrWithJ
 yfnqa+PnX/fC+H+m6+L5qAAAA
X-Change-ID: 20240919-maintainers-m-to-l-tweak-a5295c5703c2
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 soc@lists.linux.dev, Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=765;
 i=konstantin@linuxfoundation.org; h=from:subject:message-id;
 bh=00KpENy9RAHDQ6vIrsWKsLWRzDD2uX+wnmARMq1n1aE=;
 b=owGbwMvMwCW27YjM47CUmTmMp9WSGNLehi2cY3nA5Uy+gE59zvts7sN35hwoSPsevb7z+8Wag
 1Kdd4wUOkpZGMS4GGTFFFnK9sVuCip86CGX3mMKM4eVCWQIAxenAEyk5j4jw87QoIPNz0wSZr+S
 2pZ5+4vPLhWR+Q/CPu79GnC8KUt9+hFGhruTThYletpXic9e/4z5oPThW7zLP4n8rlqZpjNz6U7
 WUk4A
X-Developer-Key: i=konstantin@linuxfoundation.org; a=openpgp;
 fpr=DE0E66E32F1FDD0902666B96E63EDCA9329DD07E

Linus,

I noticed several subsystems where M: entries were pointing at mailing
lists instead of real people. These two small patches properly mark
mailing list destinations with L:, which avoids potential problems with
automation.

Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
---
Konstantin Ryabitsev (2):
      MAINTAINERS: fix PKTCDVD DRIVER to use L: for the list address
      MAINTAINERS: use the canonical soc mailing list address and mark it as L:

 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---
base-commit: de848da12f752170c2ebe114804a985314fd5a6a
change-id: 20240919-maintainers-m-to-l-tweak-a5295c5703c2

Best regards,
-- 
Konstantin Ryabitsev <konstantin@linuxfoundation.org>

