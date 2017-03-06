Return-Path: <jonathan.derrick@intel.com>
Subject: Re: block/sed-opal.c: 2 * bad if tests ?
To: David Binderman <dcb314@hotmail.com>,
 "scott.bauer@intel.com" <scott.bauer@intel.com>,
 "rafael.antognolli@intel.com" <rafael.antognolli@intel.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <DB5PR08MB096759FCAD880317DBA854FD9C2C0@DB5PR08MB0967.eurprd08.prod.outlook.com>
From: Jon Derrick <jonathan.derrick@intel.com>
Message-ID: <9b98f762-ca72-1f6a-6f28-d42138389df7@intel.com>
Date: Mon, 6 Mar 2017 08:19:33 -0700
MIME-Version: 1.0
In-Reply-To: <DB5PR08MB096759FCAD880317DBA854FD9C2C0@DB5PR08MB0967.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/06/2017 05:00 AM, David Binderman wrote:
> Hello there,
> 
> 1.
> 
> block/sed-opal.c:2136:40: warning: logical �and� of mutually exclusive tests is always false [-Wlogical-op]
> 
> Source code is
> 
>     if (lk_unlk->session.who < OPAL_USER1 &&
>         lk_unlk->session.who > OPAL_USER9) {
> 
> 2.
> 
> block/sed-opal.c:2319:37: warning: logical �and� of mutually exclusive tests is always false [-Wlogical-op]
> 
>     if (opal_session->who < OPAL_USER1 &&
>         opal_session->who > OPAL_USER9) {
> 
> Duplicate.
> 
> Also in the same file:
> 
> [block/sed-opal.c:1034]: (style) Variable 'method' is assigned a value that is never used.
> 
> Regards
> 
> David Binderman
> 
Thanks for the catch(es). Will provide patch shortly
