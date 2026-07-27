Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930D81D5CD1
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 04:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785125460; cv=fail; b=RECAc7y2BsGFOaBBzmsskCNQVGVr3WwSdWZPFWX4pFXupJTcQ4/QelD4mQtbJgy/KilJAlCiOfftc5P98hNpBoPZphNm4VW59zDhJk802CTNYyitPLRiR06cqIY7HW9VZWJvJHceMDdStWvxfOcZ1poq5X4g0lHd/s5P4rRgo18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785125460; c=relaxed/simple;
	bh=TXhvk7pP+HKxqL58w9xmwTn9nTX3M4GRB022kVDOlp8=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Er64usmLt7hXFAplyl70Dx+fHlLwvfnJ1WrTG5M6zcD5YRceuqB2XCJLXAL66JgGBARIC5LgswJgSVYO096UtKn1gR11x/XAQ4/8359C7p1ZMPv1erIyMvzgfG0fK4CaGoeBtYeK+lVLbJDrVOmX0AVcX7NLX4Rqx/hcbivKz8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PAEU4HsI; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=v6tn4LJ2; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PAEU4HsI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="v6tn4LJ2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1785125458; x=1816661458;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=TXhvk7pP+HKxqL58w9xmwTn9nTX3M4GRB022kVDOlp8=;
  b=PAEU4HsI2pBur/+JzCYN8h4wRlSnz6RuzlebciP7eda7eA+4Fsn/aALJ
   SMkf9aPkr0oEAa0/tVLfdxFWqFy0wPSDJlnYgFPikErQGB5wMTvkghP8w
   WKbmvPiGnJ54keu3tHRBKSyrB0H1ZC8DLv2C/fNCgUyE8cWUjM6ffptO2
   hHRN7eGwaclEyCb4cRhA01jaW9UbLlWtgMUgRwl6f3mADHkaCUnMRC9Df
   mtgc0BBaKa47vEteVfs8tz5QKRHzYNXgibFt7Y00TdnaPe6TIKOhRCkLO
   WCmHfTGF2bRZyPzZ9aFx47Mc4VneEH5ERd8ZnueGXQotiiMi7MTZWbkxm
   Q==;
X-CSE-ConnectionGUID: TLq0FTqoQJqx/nkS7JP50g==
X-CSE-MsgGUID: l2ZpPrZ6Qf6NpvpUyGtw6A==
X-IronPort-AV: E=Sophos;i="6.25,187,1779120000"; 
   d="scan'208";a="152754691"
Received: from mail-westus3azon11011068.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.68])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2026 12:10:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4xWuxofHF/bYubQxW95u+kgOMNqrvk7XhwcLcqn9zQzS/gUMftVlR3Yld9E1CTGcl8gblbg+MNSysvu79xDW85yZEe2GGrD/cXgFhVZrqGaDrp5eK6ajrRN0m8WxqdMPpR0Oao+uO0I+n15cLag2MWOphnGZ6r1eI3t/5ADOKjRFh55TgaqNnYFfLNaiudZNuuWlp1CGNAxFyCnLUGjTnS0KY4NNoRXthoqF3ZWctdJqqURyClzfi4aSUK+rihhKBzdY95yftamjTsrBjJ+zSJsysWQFKvo/MC38+kXCTakDH12ogdgmEgNNAApIcB5hWh+zXF0rn2BvxZwQck1Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjnhQBqtkpqlvDyuVn1e03k9PN3RHR4p/0uao4iMkk4=;
 b=OwnTzHbTZxz2ZIQAPKB8CzMycKBGCRldxH0zLG6x+2yMziYvXDFTM1SAvI8pzXizhgPIHmu7FotAHi6mPY/maST9Jjq8p88NZ7OZKh0S7xfV0FNi66Ngc5z/EvCxmWLIOZ/46ld2UTo1aVnQC0M43lZMA8ZBh5xpXL4H+eQdATNjSs3+TViJWFBsr+qwVVUzjos1JPIW7UPK3N7cwiY6r9i0MIyAgbc1QWSy7YwzSWFnoSlZWRNFXqEpXcjtjHa2OhyEkJXbG8R6WpDF8sWI42ggysAFmJwCZVc3h/gwSADmuiB/Mo2js8TmSDuAT6+H62/xeHz8GZtS3mYoH4SoIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjnhQBqtkpqlvDyuVn1e03k9PN3RHR4p/0uao4iMkk4=;
 b=v6tn4LJ2GFwfLMGgH77f2EsgK+JmHT7ImFUFH0B4PemnkSxLtkUmuo9W+js/EQMJqWp2y94b9Og3v0Kn/3cFVJhTaFlX/Vs0kPgJiUVy6u8O8z+Fl4mTjwWwIgee4yJEfEcpVjUUTZo43Ia8UgLoTe0pk8Emg3nDJmyR2RohJQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CH2PR04MB6645.namprd04.prod.outlook.com
 (2603:10b6:610:92::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Mon, 27 Jul
 2026 04:10:47 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 04:10:47 +0000
Date: Mon, 27 Jul 2026 13:10:41 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>, 
	Ming Lei <ming.lei@redhat.com>, Ming Lei <tom.leiming@gmail.com>, 
	Keith Busch <kbusch@kernel.org>, Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>, 
	Li Zhijian <lizhijian@fujitsu.com>, Akinobu Mita <akinobu.mita@gmail.com>, 
	John Pittman <jpittman@redhat.com>
Subject: Re: blktests: call for agreement to relicense GPL-2.0 files
Message-ID: <ama1svBbdVfyEKz1@shinmob>
References: <akyeX0hlcrnOC0nT@shinmob>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akyeX0hlcrnOC0nT@shinmob>
X-ClientProxiedBy: TY4PR01CA0042.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::7) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CH2PR04MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: f83294d6-51f2-472a-54a5-08deeb95099c
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|23010399003|1800799024|921020|3023799007|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4w3Kb+a+Y8UJOHbT2VhnWXM16Tv4yAMzlclc/XU0eV1OrWSz6yjDdFP8QhZAB1SdKgRwND3Oa2wNPV6ZDK0AxBCbcHOEuyAlkg6uDjrytVY/Y6sPssyBp6I9v73b4I5MqqPMCCQJMeADGwuBK6RR+re4DYtYKOH67f1Wf3dQkowZHNA0zbNMsK59bDYtf0kwBZ+ErIFgTZPoMUQTKGYu2sjpj5r6ZumtOS0UQWdXAkAHwa8FazSpnDHC/LA4+937FWgm2uZbH2b9B+rwOIXD/dvm595kXFwbCnuAMli6PyNOSgKyzoIokfgjGP6X2lFoSPL+30l8EGOZjx29sfu4lLeBK2J6P04fb625DD5LM0ryu0fgZFkaNby2PJyXJweuSC0tG3qOgUh4lVAFNCiYH8UWnoCXon6iwzchyaGU8Gli/8F7J2ECjd64psdoKB28cwuTGjXSn9OO/d9K4t2Hala9DWacGit2y+5zxlpScgcP1Orx/7xhS6UjRLuOi8ha6PdgowPd3UvLZGMsiWeiDQRDVmlJ9q9/pKiJGiE/6578gU2pjPNVjl3PJsM774foDyU5YVpRfzKWZdTRRJKuGHaR3axEThAf06aKlZmL45YT0pl1tQmRkWR+gvbu54smxFp96rA04fByZzgAYGi4eMdG1tFrDru+2FHnZLbftfI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(23010399003)(1800799024)(921020)(3023799007)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zqsPexjnnSBMlkKHT5FUQaaSHzvdBQtMhQgE+q0Hh3Ald4v6t+/tw/rlbyrc?=
 =?us-ascii?Q?Czkb1tjsPSCaUExCpAtUZTWQbSKZRBl6EydZac58kDisM1yw0BEhjSPOuAz3?=
 =?us-ascii?Q?vmOfcn0erG8OT4ZClkaCq7Ly1seT5y2Gl+CpjxL4bYh1n6hjHUklDpKtgYSE?=
 =?us-ascii?Q?EdpW7Y8Xp7L4PrF74YdUVjBwTzfHFVirPA1eMFlXygvilbsjMNOwdVx/a33Q?=
 =?us-ascii?Q?TNjcOzClNWDao8YDxb9OsiE1Hf8WNKWQrSew5gxMViSCvMuy1/FGhAtdVv1d?=
 =?us-ascii?Q?FTKB6wZmownK7TMo+HpUWwg+IUjFWR7HUQW54/1wE9QDPxedKeZlGl4//X/H?=
 =?us-ascii?Q?01kOiWDjujq5RtfZ0xs0qfZk0MODSlSfMWGC+JfzxJyueHZixVHPkrg40uk8?=
 =?us-ascii?Q?Ydwn5dRZ8LdAjk5ku8tHMFXnHqV3M342L/OY1sUQpnTxGFdjizBzVOPrtJeN?=
 =?us-ascii?Q?2oBALCgYYZAMa4L/DNkyfGgafYAhGaS/6zQB4XP9NmtEKmu5GpJx0AmdqfQQ?=
 =?us-ascii?Q?1qkT1cdjZYdEyzSlHCsI5vIWEx4CX6Bg5Lpk3KBFlYnHDAHYBcy7BzW10W5y?=
 =?us-ascii?Q?hZquQkcAHVBXcLO/0MNQLs8OSsX2D+8RkOoV1Ii6Wzgz+3NF94CsgT+acu1O?=
 =?us-ascii?Q?xp+7Gd7QjYJvInO/DQFXKjV8s59H4TSwmwD+cFC+emwAfYYPGZt91t4MK+1x?=
 =?us-ascii?Q?LXM/M4AA7Qqtlip7a0hra+IwmZiQvcq0sprGLE+atrT9itunBxKEuYc5mBOP?=
 =?us-ascii?Q?TWqqMihmghwPXejxsaXTOjBmVX1GNvA4oP+cJM0icNR0xqlGpWpFiTtwoPSn?=
 =?us-ascii?Q?D2Yg+ZmTq14Pc7Ibd2ZM/qxZo/BoCHCesnx6ZJTSQI0HU43Nt5EEFbIKqtMN?=
 =?us-ascii?Q?XHuB4LdNZpc3+rf7Z24cpr7hyAukihyrPJYywc7S2k/p4T/gJtgsOyJEfDSv?=
 =?us-ascii?Q?oKRjkgNWxqBjn9nDjil5Hm/QHfCJbwj9jMwnZKfdg34jBjT/er8Zf/UYzgRN?=
 =?us-ascii?Q?h6+iIkVRx4moUz0jup56kfhSsqw5iefIbisM5Fo8i5Ch9E+Nu0lwRFxXgKzb?=
 =?us-ascii?Q?1BV7ahmJlFi0dmQ5yj2PGcTn/pELHXCeRA44f5UiE8LfVuJUlc6sIuQMiUZ0?=
 =?us-ascii?Q?cXLSKVkLCtOqeqMqiA5Nf4RlNBl9q441zfr54ql66zhK3nU1KRGw5ar56yi1?=
 =?us-ascii?Q?QmoNxlubbgvtvEeb41HjadnRp9QlPfpRn8SjyyKzZX2j/srBOoRqxKPTMCAL?=
 =?us-ascii?Q?4K91Ii3yytUPs37/p8V5EIplbW2imyib1FwQyTM3bxEj9k4ercMvNQubJNG3?=
 =?us-ascii?Q?08MDu2FoqwBPGQIH8ym0tLV+8FLDdikM7jJpVlKizu47cLcVIOWAAm4w8sjz?=
 =?us-ascii?Q?XTuuPLAIq1N9HB9svTxvUAW9rt/8VO1/ODByNwegmUhV/l4pDkYauGd6HiTJ?=
 =?us-ascii?Q?3MMLDBA/BnesS5THgBjDLwMhPYzluChbD7KgQ1TuvFGN6BzY/AIJjc+qffCO?=
 =?us-ascii?Q?9IApWxjhz/El8+SeiWHb1z4Mpc4eK54+mbfXEub8jfV93opXf2aARWunjFv/?=
 =?us-ascii?Q?DQAmTj+bdtLlN5UYHWrZCt5sfN0aV9e+/E5trzXQKpxWBcQAO70VtiZS16TS?=
 =?us-ascii?Q?iTJUAwd5cPEbTmoMWkgiS3Lz9pAYEHsitDZP79vkIBuHz2c95KNyZgb5piE0?=
 =?us-ascii?Q?fc3vtUZ5eBWV+7oviP9VaO27LuqPKr4eNMkrJtPLWPTpBL9FkiWRLxJ5K5dO?=
 =?us-ascii?Q?BSXl5FBIp7kf05QKy1wJfVxynCUHumk=3D?=
X-Exchange-RoutingPolicyChecked:
	K9Dkbtf34D0Fnl+L8xjoeCx6Y5aSUvSLyh6Ec+QjGWcgOU8r7JIBeqb9AehfMduoB/Rom1RRbVquUu7w1xt1GoS0JmARru2ElTxMV0DAAOlsvg1EwUV4Aa8D+a2kXFKBUIuEtC6mW9CL8gnmyIXDo3wlAda1/UODWaV+kCZk5AaxCz9QJoBwUVnlUT2AqtLNFzjFl8oEYgZ2dxvA5pYlK2GooOd0NzdPrMh5f5fDn0hz4MoOdgW5qwOBDVt31gizECjNSlJcL/bZbnorUejZPGCLk7gPf6cNdMniCxYx6Xs2/mOgdKRNkNTiHcF4RZrGRKwCRzxWsjflauDV1Tz9jQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2XqJ6e81m3JUvGb98b9mdGR+7LfSET6um4RQ/h7yp/ITzMFeAupNTTSGUiWGx74xdNPLeIa6BdRatkdNP7vt1vz1JAxY0eOcJj+OR5rsOZNjgx5XyLL+qXXsR/zNVtgCrplMYvQSG/3rUkv+5tdAQpkOHw9U4AL6r/EsSAScr+ISbZLnx8eiib36u3bmeeJ1TlfOqk27vlqkMRYrWRWZmk3y4VDxHUSp+XwuN94JWDBCpIPPBYNSKdE7red4DCqhOdGSRrCt52wR31OS+HVG0dp8D4XUwNSDBpsWYQjteNbSHVHZQmizl+IM57FbWl9ZK4buIjUUi8xNrzVPkPLjnpAwhUYidXRVfpz0abPPe5H0e+X5gTjBLTVcWfe5PiFaV1DJIbnVu96aH6KR4+AT6ZKnEdFjpenKYyRePDN4A8y9rovsz5ubGlgvz2a4dAUMgqXrLrZiGuqZCI2a8MGHRjQBPh9t3Raqyx+VtkqxaJKRkN0aJx89nM3rln2a7G60BuFYFKVGpWwpHJYL9PwMS13rH2ShG8oMmpwfWJ538vVuFXiC+V+1klqHDtYJ2jE8/bXb99CmJiw1wxItZWkScKqdDi+Nvexu9CPqRzluUbH3g6a4D7IV+FnXzkUW+x4E
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f83294d6-51f2-472a-54a5-08deeb95099c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 04:10:47.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dB7CTOUaKi7tEmeYe0S8FqINozkYN5M8bPi4Vp2WeTSexadoPTHxQiU4ENSzEMUUUwqt+2jo77reiQ9EIVhgtP9UYWB1176MQrDfE19qY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6645

Three weeks have passed since my call for agreement. Thank you very much to
those who responded. There was no objection to the change. I conclude that
the agreement has been made, and would like to take the next step for the fix.

 - John Pittman did not respond, but I confirmed off-list that he has no
   objection to the change.

 - I did not get a response from Yi Zhang's Red Hat address. I tried to reach Yi
   Zhang via the e-mail address on Yi Zhang's GitHub account, but received no
   response there either. I concluded it is not productive to wait any longer.

   Yi Zhang's contributions to the relevant source files are the two commits
   below:

   A) 38fc272ee91f ("tests/block: add the missing _have_fio check for block/029 block/031")
   B) 06cd1d595571 ("block/031: remove the fio verify.state file")

   These are small changes that added a couple of _have_fio calls and a fio
   option. I think it is reasonable to consider the changes as "de minimis"
   and they do not prevent the relicense.


Bart, Ming and Keith,

  May I ask you to create and post a patch to change the license of the files
  you authored from GPL-2.0 to GPL-3.0+?

  - Bart: block/029,030,031
    Contributors: Christoph Hellwig <hch@lst.de>
		  Li Zhijian <lizhijian@fujitsu.com>
		  Akinobu Mita <akinobu.mita@gmail.com>
		  Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
  - Ming: block/040
  - Keith: block/042,043, src/dio-offsets.c
    Contributors: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
		  John Pittman <jpittman@redhat.com>
		  Bart Van Assche <bvanassche@acm.org>

  If you are too busy, please let me know. I can create the patch on your
  behalf, but since this is a license change, it's better if you author it
  yourselves.

Bart and Keith,

  When you post the patch, please CC the contributors, so that they can
  provide their Acked-by tags.

Contributors,

  When you receive the CCed patches, please respond with your Acked-by tag
  to record your agreement to the relicense.

Bart,

  Could you please note in the commit message that Yi Zhang's two commits A)
  and B) above are regarded as "de minimis"? I drafted the description as
  below:

    Because Yi Zhang did not respond to the relicensing request (contacted via
    e-mail addresses on Red Hat and on the GitHub account), and commits A) and
    B) by Yi Zhang are regarded as de minimis, acknowledgement by Yi Zhang is
    not expected.

Thanks in advance for your cooperation.


On Jul 07, 2026 / 15:38, Shin'ichiro Kawasaki wrote:
> Hello blktests contributors,
> 
> Recent discussion unveiled a license inconsistency [1]. Currently, each file of
> blktests has one of the licenses: GPL-2.0, GPL-2.0+ or GPL-3.0+. Majority of the
> blktests code has GPL-3.0+, so the effective main license is GPL-3.0+ (e.g.,
> check, common/rc). However, GPL-2.0 and GPL-3.0 are not compatible with each
> other [2]. Because the majority of blktests is GPL-3.0+, blktests cannot contain
> GPL-2.0 files. All files shall be GPL-2.0+ or GPL-3.0+.
> 
>   [1] https://lore.kernel.org/linux-block/20260626045650.GA8752@lst.de/
>   [2] https://www.gnu.org/licenses/gpl-faq.html#v2v3Compatibility
> 
> As of July 2026, seven files below have GPL-2.0. It is desired to change their
> license to GPL-2.0+ (or GPL-3.0+). The list below shows Authors and Contributors
> of each file. "Author" means the original file creator who set the license
> GPL-2.0. "Contributor" means those who made changes to the files later on.
> 
> 1) block/029
>     Author: Bart Van Assche <bvanassche@acm.org>
>     Contributors: Yi Zhang <yi.zhang@redhat.com>
> 		  Christoph Hellwig <hch@lst.de>
> 		  Li Zhijian <lizhijian@fujitsu.com>
> 
> 2) block/030
>     Author: Bart Van Assche <bvanassche@acm.org>
>     Contributors: Christoph Hellwig <hch@lst.de>
> 		  Li Zhijian <lizhijian@fujitsu.com>
> 		  Akinobu Mita <akinobu.mita@gmail.com>
> 
> 3) block/031
>     Author: Bart Van Assche <bvanassche@acm.org>
>     Contributors: Yi Zhang <yi.zhang@redhat.com>
> 		  Christoph Hellwig <hch@lst.de>
> 		  Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> 4) block/040
>     Author: Ming Lei <ming.lei@redhat.com>
> 
> 5) block/042
>     Author: Keith Busch <kbusch@kernel.org>
>     Contributors: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 		  John Pittman <jpittman@redhat.com>
> 
> 6) block/043
>     Author: Keith Busch <kbusch@kernel.org>
>     Contributors: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> 7) src/dio-offsets.c
>     Author: Keith Busch <kbusch@kernel.org>
>     Contributors: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 		  Bart Van Assche <bvanassche@acm.org>
> 
> 
> To the authors and the contributors,
> 
>   I would like to call for your responses. Please let us know if you agree to
>   modify the license of the files from GPL-2.0 to GPL-2.0+ (or GPL-3.0+).
> 
> 
> I will wait for a few weeks to gather responses. Once agreement gets
> estabilished, I will ask the authors to submit patches to make the license
> change. Any other general comments on this topic will be appreciated also.
> 
> And as one of the contributors, here I express my agreement to change the
> license of the files :)
