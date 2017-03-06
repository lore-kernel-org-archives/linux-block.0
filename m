Return-Path: <dcb314@hotmail.com>
From: David Binderman <dcb314@hotmail.com>
To: "scott.bauer@intel.com" <scott.bauer@intel.com>,
	"jonathan.derrick@intel.com" <jonathan.derrick@intel.com>,
	"rafael.antognolli@intel.com" <rafael.antognolli@intel.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: block/sed-opal.c: 2 * bad if tests ?
Date: Mon, 6 Mar 2017 12:00:17 +0000
Message-ID: <DB5PR08MB096759FCAD880317DBA854FD9C2C0@DB5PR08MB0967.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Return-Path: dcb314@hotmail.com
List-ID: <linux-block@vger.kernel.org>

Hello there,

1.

block/sed-opal.c:2136:40: warning: logical =91and=92 of mutually exclusive =
tests is always false [-Wlogical-op]

Source code is

    if (lk_unlk->session.who < OPAL_USER1 &&
        lk_unlk->session.who > OPAL_USER9) {

2.

block/sed-opal.c:2319:37: warning: logical =91and=92 of mutually exclusive =
tests is always false [-Wlogical-op]

    if (opal_session->who < OPAL_USER1 &&
        opal_session->who > OPAL_USER9) {

Duplicate.

Also in the same file:

[block/sed-opal.c:1034]: (style) Variable 'method' is assigned a value that=
 is never used.

Regards

David Binderman
