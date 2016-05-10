Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10332 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753538AbcEJAWT (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Mon, 9 May 2016 20:22:19 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u4A0LuGv016050
	for <linux-block@vger.kernel.org>; Mon, 9 May 2016 17:22:18 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
	by mx0a-00082601.pphosted.com with ESMTP id 22u4pgr2c9-1
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 09 May 2016 17:22:18 -0700
Received: from facebook.com (2401:db00:11:d0a2:face:0:39:0)	by
 mx-out.facebook.com (10.223.100.99) with ESMTP	id
 40177ffe164511e6b23f24be05956610-e0bfdc50 for <linux-block@vger.kernel.org>;
	Mon, 09 May 2016 17:22:16 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Steven Rostedt <rostedt@goodmis.org>, <axboe@fb.com>,
	<Kernel-team@fb.com>
Subject: [PATCH 2/3] blktrace: add missed mask name
Date: Mon, 9 May 2016 17:22:14 -0700
Message-ID: <ea5ffed7a013bf524d3576cdff8ad00d11a68bf2.1462838969.git.shli@fb.com>
In-Reply-To: <2c3ee532132f8925dd0be1178e8dee0bba6b448c.1462838969.git.shli@fb.com>
References: <2c3ee532132f8925dd0be1178e8dee0bba6b448c.1462838969.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

BLK_TC_NOTIFY is missed in mask_maps, so we can't print out notify or
set mask with 'notify' name.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 kernel/trace/blktrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8ae9ea2..9aef865 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1552,6 +1552,7 @@ static const struct {
 	{ BLK_TC_COMPLETE,	"complete"	},
 	{ BLK_TC_FS,		"fs"		},
 	{ BLK_TC_PC,		"pc"		},
+	{ BLK_TC_NOTIFY,	"notify"	},
 	{ BLK_TC_AHEAD,		"ahead"		},
 	{ BLK_TC_META,		"meta"		},
 	{ BLK_TC_DISCARD,	"discard"	},
-- 
2.8.0.rc2

