Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D7ED266
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Q+GdpZz0"
X-Greylist: delayed 157 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Nov 2023 23:07:08 PST
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448E410D3;
	Tue,  7 Nov 2023 23:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1699427226; bh=6QRXC/jRCK6v3iW6/MujzifYFAs4A/s8xRoN+wE/wAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q+GdpZz0u7guWlMzmz0/Vqa+APcrDweDBKGFFAeJwkLmL++9ePVjAmjIcVsCGI6ff
	 MI67smGEXYuFHyRFychvQHvs+tw5l3Icyni7GPnYwLTM7qlpU+gt6aki6hoiqyyjXP
	 yTVdo1XIc95KloHF+1QHXNeq7Ak9YJUwr7LGg5to=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 1C33AEA0; Wed, 08 Nov 2023 15:07:03 +0800
X-QQ-mid: xmsmtpt1699427223trgln31s4
Message-ID: <tencent_75EE2562BAB7BB5A337A9E2F1B054B421B08@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9R6IjZziZUrfQR6jw3DJCNAZtAQIhtA+WwfNQJQEmzmip1PmYVv
	 mZhHQMmkVFlswb4oa+HEXOJ1yucc7j8e0/53LwyH80KqTiPAHS+ZX1B5aBirfc9lIayAYFRul+zo
	 B1Q/DeqIy/Or82EJpthSN7Pm2ODhctWu8Yv/fgbKtdL/tUc3SOh9tz+tdqbFTBE6+w593LqTejoV
	 YE/CV0nFivjfUT3l/lM7Q0XlrzJw98H4M4rw7IlttCliuUNz5YXBjHTN8lKjXVD119swvWcB93gR
	 HUAlf47W6CgHEIAUXRcxikRl+ZddnEul8ZulH1Vl1yNIpriUgp6qfhfasxHHog602QopehW/7zn1
	 YXK4eZewtYkNdGEb3cTJHr54OKERIXZ+vL0LgI5Q3L8Zx367BJcj1T2y0orQ7Y3PsZf2R/s1PnCk
	 QRRnncbCHIQ5RhleSi1znKONVuSQ+fHT0NDWjmvSAIgr8OA25ixLWeJ5C/4z/l5ryhWCo33cUdgh
	 NTm/2jUA0kaly0kZilLdlxUemvZPD/1fVV+yged/nn/PgBg57WwN2okZ0zpSngrSzs6q7TE7rKEz
	 P2wqU192TinhBCp/+sNLyBmD2rpfKOj6kKAyNPM860PxMEVVi3+PVOlevs2JQUB4Z36GlYPRCS0b
	 J5L/v2xy11qovnyuFhgNd8Bci8XpflTalGtbf0GjTHaSSVl4Kr2sDH9P0Od+MaYP1XwNFmkSfxzZ
	 aaon1bnVrrexEG2dbr6ZXqXYp0DoHGyfg2KB8P17jbp8V6eTy38Zq5lcSONWqx21vxWLWjD/0sR3
	 kd4f9zfQDvJ/pjBzIy24BOtYrsPCdk3oMPBQJ3rM/HoX0YeHNTc4kssktuwhLUqB5YtctPKsuvMi
	 960qPVpWM7YC1PWAjRiXAkhKBpbbFAh/0OtS+dHOxk6jVhmO9MEJprMUAEqmUfU23hj6hRx+DUEC
	 UxpAPVr8b1VitZJy7Fog==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: chaitanyak@nvidia.com
Cc: axboe@kernel.dk,
	eadavis@qq.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] null_blk: fix warning in blk_mq_start_request
Date: Wed,  8 Nov 2023 15:07:04 +0800
X-OQ-MSGID: <20231108070703.1503741-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <c2eee1f6-c060-4fd3-b161-2ce98a778b89@nvidia.com>
References: <c2eee1f6-c060-4fd3-b161-2ce98a778b89@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 8 Nov 2023 06:40:38 +0000 Chaitanya Kulkarni wrote:
>> Before call blk_mq_start_request() in null_queue_rq(), initialize rq->state to
>> MQ_RQ_IDLE.
>>
>> Reported-and-tested-by: syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com
>> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
>> ---
>
>do you have the actual report from syzkaller ?
you mean these?
https://lore.kernel.org/all/0000000000006510b406099a92ea@google.com/
https://lore.kernel.org/all/000000000000f0db9606099e70a1@google.com/

edward

